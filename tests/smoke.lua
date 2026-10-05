-- Run with Lua 5.2 or LuaJIT: lua tests/smoke.lua /path/to/pinned/AIO_Server
-- This mocks the engine host; it does not validate the C++ bindings or game client.
local source = assert(arg[1], "AIO_Server path required")
for _, directory in ipairs({"", "Dep_Smallfolk/", "Dep_LuaSrcDiet/", "lualzw-zeros/", "Dep_crc32lua/"}) do
    package.path = source .. "/" .. directory .. "?.lua;" .. package.path
end
local server, playerEvents = {}, {}
function GetLuaEngine() return "ALEEngine" end
function GetStateMapId() return -1 end
function GetPlayersInWorld() return {} end
function RegisterServerEvent(id, callback) server[id] = callback end
function RegisterPlayerEvent(id, callback) playerEvents[id] = callback end
function CreateLuaEvent() return 1 end
function RemoveEventById() end
function PrintInfo() end
function PrintError(message) error(message) end
local AIO = require("AIO")
assert(server[30] and playerEvents[4] and playerEvents[42], "Missing host hooks")
local sent, received
local player = assert(io.tmpfile())
player:close()
local methods = {}
debug.setmetatable(player, {__index = methods})
function methods:GetGUIDLow() return 7 end
function methods:SendAddonMessage(prefix, message, kind, target)
    assert(prefix == "SAIO" and kind == 7 and target == self)
    sent = message
end
AIO.AddHandlers("PortSmoke", { Ping = function(sender, value)
    assert(sender == player)
    received = value
end })
AIO.Msg():Add("PortSmoke", "Ping", "roundtrip"):Send(player)
assert(sent, "Message was not serialized")
server[30](30, player, 7, "MPUi", sent, player)
assert(received == nil, "AIO consumed Mythic Plus traffic")
server[30](30, player, 7, "CAIO", sent, player)
assert(received == "roundtrip", "Message did not roundtrip")
print("AIO mocked-host smoke: OK")
