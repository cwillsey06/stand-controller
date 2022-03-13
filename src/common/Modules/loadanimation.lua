local _cache = {}

return function(character: Model | Player | Humanoid | AnimationController, animationId: string | number): AnimationTrack
    local id: string = (typeof(animationId) == "string") and animationId or "rbxassetid://".. tostring(animationId):match("%d+")
    local key: string =  "track_".. id
    
    if _cache[key] then
        return _cache[key]
    else
        local function getAnimator(src: Instance): Animator?
            local base = src:FindFirstChildOfClass("Humanoid") or src:FindFirstChildOfClass("AnimationController")
            return base:FindFirstChildOfClass("Animator")
        end
        
        local animator: Animator?
        if character:IsA("Model") then
            animator = getAnimator(character)
        elseif character:IsA("Player") then
            character = character.Character
            animator = getAnimator(character)
        else
            animator = character:FindFirstChildOfClass("Animator")
        end
        
        assert(animator, "Animator object not found.")
        
        local animation: Animation = Instance.new("Animation")
        animation.AnimationId = id
        
        local track: AnimationTrack = animator:LoadAnimation(animation)
        animation:Destroy()
        
        _cache[key] = track
        return track
    end
end