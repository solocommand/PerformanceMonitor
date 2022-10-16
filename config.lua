local addonName, addon = ...
local L = addon.L
local ldbi = LibStub('LibDBIcon-1.0', true)

local function build()
  local t = {
    name = "PerformanceMonitor",
    handler = PerformanceMonitor,
    type = 'group',
    args = {
      showFPS = {
        type = 'toggle',
        order = 1,
        get = function(info) return addon.db[info[#info]] end,
        set = function(info, value) return addon:setDB(info[#info], value) end,
        name = L.showFPS,
        desc = L.showFPSDescription,
      },
      showLatency = {
        type = 'toggle',
        order = 1,
        get = function(info) return addon.db[info[#info]] end,
        set = function(info, value) return addon:setDB(info[#info], value) end,
        name = L.showLatency,
        desc = L.showLatencyDescription,
      },
      showLatencyWorld = {
        type = 'toggle',
        order = 1,
        get = function(info) return addon.db[info[#info]] end,
        set = function(info, value) return addon:setDB(info[#info], value) end,
        name = L.showLatencyWorld,
        desc = L.showLatencyWorldDescription,
      },
      showMem = {
        type = 'toggle',
        order = 1,
        get = function(info) return addon.db[info[#info]] end,
        set = function(info, value) return addon:setDB(info[#info], value) end,
        name = L.showMem,
        desc = L.showMemDescription,
      },
      showMinimapIcon = {
        type = 'toggle',
        name = L.showMinimapIcon,
        desc = L.showMinimapIconDescription,
        order = 0,
        get = function(info) return not addon.db.minimap.hide end,
        set = function(info, value)
          local config = addon.db.minimap
          config.hide = not value
          addon:setDB("minimap", config)
          ldbi:Refresh(addonName)
        end,
      },
    }
  }

  -- return our new table
  return t
end

LibStub("AceConfig-3.0"):RegisterOptionsTable("PerformanceMonitor", build, nil)
addon.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, "PerformanceMonitor")
