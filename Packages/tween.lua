local _ts = game:GetService("TweenService")
function Tween(instance : Instance, property : string, goal : any, tweenTime : number?, style : Enum.EasingStyle?, direction : Enum.EasingDirection?) : Tween
    local time, style, direction = tweenTime or 1, style or Enum.EasingStyle.Linear, direction or Enum.EasingDirection.Out
    local _ti = TweenInfo.new(time, style, direction)
    goal = {[property] = goal}
    local t = _ts:Create(instance,_ti,goal); t:Play();
    task.defer(function()
        t.Completed:Wait()
        t:Destroy()
    end)()
    return t
end
return Tween