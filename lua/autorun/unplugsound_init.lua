--[[------------------------------------
    Top 10 Best prank of all time
------------------------------------]]--

if SERVER then

    util.AddNetworkString("UnPlugSound.FullConnected")

    net.Receive("UnPlugSound.FullConnected", function(_, ply)
        net.Start("UnPlugSound.FullConnected")
        net.Send(ply)
    end)

elseif CLIENT then

    if not system.IsWindows() then return end

    local PlugInSound = "sound/windows/plugin_sound.wav"
    local UnPlugSound = "sound/windows/unplug_sound.wav"

    local NextOne = true
    
    if not file.Exists(PlugInSound, "GAME") then return end
    if not file.Exists(UnPlugSound, "GAME") then return end

    local function PlayRandomSound()
        NextOne = not NextOne
        surface.PlaySound(NextOne and PlugInSound or UnPlugSound)

        local interval = math.random(180, 900)
        timer.Simple(interval, PlayRandomSound)
    end

    hook.Add("InitPostEntity", "UnPlugSound.FullConnected", function()
        net.Start("UnPlugSound.FullConnected")
        net.SendToServer()
    end)

    net.Receive("UnPlugSound.FullConnected", function()
        timer.Simple(math.random(180, 900), PlayRandomSound)
    end)
end