local common = game:GetService("ReplicatedStorage").common
local ContactServer = common.StandService.ContactServer
local StandService = require(common.StandService)

function ContactServer.OnServerInvoke(_, invoke: string, ...: any?): any?
    return StandService[invoke](...)
end