class 'XP4FD_CQBTClient'

function XP4FD_CQBTClient:__init()
    print('Hello client!')

    Events:Subscribe('Extension:Loaded', function()
        WebUI:Init()
    end)

    Events:Subscribe('Player:UpdateInput', function()
        if InputManager:WentKeyDown(InputDeviceKeys.IDK_Escape) then
            WebUI:ExecuteJS(string.format("hide()"))
        end

    end)

    Events:Subscribe('Player:Respawn', self, function(player)

        WebUI:ExecuteJS(string.format("show()"))

    end)

    Events:Subscribe('Player:Killed', self, function(player)

        WebUI:ExecuteJS(string.format("hide()"))

    end)

end

g_XP4FD_CQBTClient = XP4FD_CQBTClient()