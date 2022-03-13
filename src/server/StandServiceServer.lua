local StandService = require(game.ReplicatedStorage.common.StandService)
local ContactServer = game.ReplicatedStorage.common.StandService.ContactServer

function ContactServer.OnServerInvoke(client: Player, invoke: string, ...: any?): any?
    return StandService[invoke](...)
end