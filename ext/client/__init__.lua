class 'XP4FD_CQBTClient'

function XP4FD_CQBTClient:__init()
    print('Hello client!')

    self.screens = {}

    Events:Subscribe('Extension:Loaded', function()
        WebUI:Init()
    end)

    Events:Subscribe('Level:LoadingInfo', function(screenInfo)
        if screenInfo == "Initializing entities for autoloaded sublevels" then
            WebUI:ExecuteJS("showLoadingScreen()")
        end
    end)

    Events:Subscribe('Level:Destroy', function()
        WebUI:ExecuteJS("hideLoadingScreen()")
    end)

    Events:Subscribe('Partition:Loaded', self, self.OnPartitionLoaded)

    Hooks:Install('UI:PushScreen', 999, self, self.OnPushedScreen)

end

function XP4FD_CQBTClient:OnPushedScreen(hook, screen, graphPriority, parentGraph)

    if screen == nil then
        return
    end

    local screen = UIGraphAsset(screen)

    print("Pushed: " .. screen.name)

    if screen.name == 'UI/Flow/Screen/SpawnScreenPC' then
        WebUI:ExecuteJS("hide()")
    end

    if screen.name == 'UI/Flow/Screen/IngameMenuMP' then
        WebUI:ExecuteJS("hide()")
    end

    if screen.name == 'UI/Flow/Screen/HudTDMScreen' then
        WebUI:ExecuteJS("show()")
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
            self.screens[s_Instance.name] = UIGraphAsset(l_Instance)
        end
    end

end

g_XP4FD_CQBTClient = XP4FD_CQBTClient()