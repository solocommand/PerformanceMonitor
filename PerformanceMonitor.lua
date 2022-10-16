local addonName, addon = ...
local L = addon.L
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local ldbi = LibStub:GetLibrary('LibDBIcon-1.0')
local AceTimer = LibStub("AceTimer-3.0")
local timer = nil;

local function showConfig()
  InterfaceOptionsFrame_OpenToCategory(addonName)
  InterfaceOptionsFrame_OpenToCategory(addonName)
end

local function normal(text)
  if not text then return "" end
  return NORMAL_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end

local function red(text)
  if not text then return "" end
  return RED_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end

local function yellow(text)
  if not text then return "" end
  return YELLOW_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end

local function green(text)
  if not text then return "" end
  return GREEN_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end

local function highlight(text)
  if not text then return "" end
  return HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end

local function muted(text)
  if not text then return "" end
  return DISABLED_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end


-- Init & config panel
do
  local eventFrame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
  eventFrame:SetScript("OnEvent", function(self, event, loadedAddon)
    if loadedAddon ~= addonName then return end
    self:UnregisterEvent("ADDON_LOADED")

    if type(PerformanceMonitorSettings) ~= "table" then PerformanceMonitorSettings = {currencies={},minimap={hide=false}} end
    local sv = PerformanceMonitorSettings
    if type(sv.minimap) ~= "table" then sv.minimap = {hide=false} end
    if type(sv.showFPS) ~= "boolean" then sv.showFPS = true end
    if type(sv.showLatency) ~= "boolean" then sv.showLatency = true end
    if type(sv.showLatencyWorld) ~= "boolean" then sv.showLatencyWorld = false end
    if type(sv.showMem) ~= "boolean" then sv.showMem = true end
    addon.db = sv

    ldbi:Register(addonName, addon.dataobj, addon.db.minimap)
      self:SetScript("OnEvent", nil)
  end)
  eventFrame:RegisterEvent("ADDON_LOADED")
  addon.frame = eventFrame
end

-- data text
do
  local f = CreateFrame("frame")
  local text = "..loading.."
  local tooltip = ""
  local dataobj = ldb:NewDataObject("PerformanceMonitor", {
    type = "data source",
    icon = "Interface\\AddOns\\PerformanceMonitor\\PerformanceMonitor",
    text = text,
    OnEnter = function(frame)
      GameTooltip:SetOwner(frame, "ANCHOR_NONE")
      GameTooltip:SetPoint("TOPLEFT", frame, "BOTTOMLEFT")
      GameTooltip:ClearLines()
      addon:updateTooltip(frame)
      GameTooltip:Show()
    end,
    OnLeave = function()
      GameTooltip:Hide()
    end,
    OnClick = function(self, button)
      showConfig()
    end,
  })

  addon.dataobj = dataobj

  local function fmtLabel(text)
    if not text then return "" end
    text = normal(text);
    return " "..normal(text)..": ";
  end

  local function updateText()
    local fps = GetFramerate();
		local _, _, latencyHome, latencyWorld = GetNetStats();
    local memory, gcThreshold = gcinfo();

    local function getFPS()
      local function color(v)
        if (v >= 60) then
          return green(format('%2.1f', v))
        elseif (v >= 30) then
          return yellow(format('%2.1f', v))
        end
        return red(format('%2.1f', v))
      end
      return fmtLabel(L.labelFPS)..color(fps)
    end

    local function getLatency()
      local t = fmtLabel(L.labelLatency)
      local function color(v)
        if (v <= 300) then
          return green(format('%d', v)..'ms')
        elseif (v <= 600) then
          return yellow(format('%d', v)..'ms')
        end
        return red(format('%d', v)..'ms')
      end
      if (addon.db.showLatency) then
        t = t..color(latencyHome)
      end
      if (addon.db.showLatency and addon.db.showLatencyWorld) then
        t = t.." "
      end
      if (addon.db.showLatencyWorld) then
        t = t..color(latencyWorld)
      end
      return t
    end
    local function getMemoryUsage()
      local function color(v)
        -- @todo thresholds?
        return highlight(format('%.3f', v / 1024).." MB")
      end
      return fmtLabel(L.labelMem)..color(memory)
    end


    local text = "";
    if (addon.db.showFPS) then text = text..getFPS() end
    if (addon.db.showLatency or addon.db.showLatencyWorld) then
      text = text..getLatency()
    end
    if (addon.db.showMem) then text = text..getMemoryUsage() end

    dataobj.text = text;
  end

  function addon:updateTooltip()

    GameTooltip:AddLine(L["PerformanceMonitor"].."\n")

  end

  function addon:setDB(key, value)
    addon.db[key] = value
    updateText()
  end

  f:RegisterEvent("PLAYER_ENTERING_WORLD");
  f:SetScript("OnEvent", function(self, event)
    if not timer then
      -- @todo should this only run when the datatext is displayed?
      timer = AceTimer.ScheduleRepeatingTimer("PerformanceMonitor", updateText, 1.5 )
    end
  end)
end
