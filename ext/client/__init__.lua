class 'XP4FD_CQBTClient'

function XP4FD_CQBTClient:__init()
    print('Hello client!')

    self.screens = {}

    Events:Subscribe('Extension:Loaded', function()
        WebUI:Init()
    end)

    Events:Subscribe('Partition:Loaded', self, self.OnPartitionLoaded)

    Hooks:Install('UI:PushScreen', 999, self, self.OnPushedScreen)

    Events:Subscribe('Player:UpdateInput', function()
        if InputManager:WentKeyDown(InputDeviceKeys.IDK_Escape) then
            WebUI:ExecuteJS(string.format("hide()"))
        end
        if InputManager:WentKeyDown(InputDeviceKeys.IDK_Escape) then
            WebUI:ExecuteJS(string.format("show()"))
        end
    end)

    Events:Subscribe('Player:Respawn', self, function(player)

        WebUI:ExecuteJS(string.format("show()"))

    end)

    Events:Subscribe('Player:Killed', self, function(player)

        WebUI:ExecuteJS(string.format("hide()"))

    end)

end

function XP4FD_CQBTClient:OnPushedScreen(hook, screen, graphPriority, parentGraph)
    local screen = UIGraphAsset(screen)
    if screen.name == 'UI/Flow/Screen/HudTDMScreen' then
        hook:Pass(self.screens['UI/Flow/Screen/EmptyScreen'], p_GraphPriority, p_ParentGraph)
        WebUI:ExecuteJS('showLoadingScreen()')
    end
end

function XP4FD_CQBTClient:OnPartitionLoaded(partition)

    local instance = partition.instances
    for _, l_Instance in ipairs(instance) do
        if l_Instance == nil then
            print('Instance is null?')
            break
        end

        if l_Instance.typeInfo.name == "UIScreenAsset" then
            local s_Instance = UIGraphAsset(l_Instance)
            print("Found: " .. s_Instance.name)
            self.screens[s_Instance.name] = UIGraphAsset(l_Instance)
        end
    end

end

g_XP4FD_CQBTClient = XP4FD_CQBTClient()