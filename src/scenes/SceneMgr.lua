
local SceneMgr = {}

local _curr_scene
local _curr_name

--
function SceneMgr.RunScene(name)
    
    if _curr_name == name then
        return
    end

    if _curr_scene and _curr_scene.OnLeave then
        _curr_scene:OnLeave()
    end

    _curr_scene = require("scenes." .. name):new()
    display.runScene(_curr_scene)

    if _curr_scene and _curr_scene.OnEnter then
        _curr_scene:OnEnter()
    end
    
    _curr_name = name
end


function SceneMgr.SceneName()
    return _curr_name
end

return SceneMgr