
local addonName, addon = ...

local L = {}

L.PerformanceMonitor = 'PerformanceMonitor'

L.showMinimapIcon = 'Show minimap button'
L.showMinimapIconDescription = 'Show the PerformanceMonitor minimap button'
L.showFPS = 'Show FPS'
L.showFPSDescription = 'Show the frames per second in the data text'
L.showLatency = 'Show ping'
L.showLatencyDescription = 'Show the ping (latency) to the home server in the data text.'
L.showLatencyWorld = 'Show ping (world)'
L.showLatencyWorldDescription = 'Show the ping (latency) to the world server in the data text.'
L.showMem = 'Show memory usage'
L.showMemDescription = 'Show the addon memory usage in the data text.'

L.labelFPS = 'FPS'
L.labelLatency = 'Latency'
L.labelMem = 'Memory'

L["TITAN_FPS_FORMAT"] = "%.1f";
L["TITAN_FPS_BUTTON_LABEL"] = "FPS: ";
L["TITAN_FPS_MENU_TEXT"] = "FPS";
L["TITAN_FPS_TOOLTIP_CURRENT_FPS"] = "Current FPS: ";
L["TITAN_FPS_TOOLTIP_AVG_FPS"] = "Average FPS: ";
L["TITAN_FPS_TOOLTIP_MIN_FPS"] = "Minimum FPS: ";
L["TITAN_FPS_TOOLTIP_MAX_FPS"] = "Maximum FPS: ";
L["TITAN_FPS_TOOLTIP"] = "Frames Per Second";

L["TITAN_LATENCY_FORMAT"] = "%d".."ms";
L["TITAN_LATENCY_BANDWIDTH_FORMAT"] = "%.3f ".."KB/s";
L["TITAN_LATENCY_BUTTON_LABEL"] = "Latency: ";
L["TITAN_LATENCY_TOOLTIP"] = "Network Status";
L["TITAN_LATENCY_TOOLTIP_LATENCY_HOME"] = "Realm Latency (home): ";
L["TITAN_LATENCY_TOOLTIP_LATENCY_WORLD"] = "Game Latency (world): ";
L["TITAN_LATENCY_TOOLTIP_BANDWIDTH_IN"] = "Bandwidth In: ";
L["TITAN_LATENCY_TOOLTIP_BANDWIDTH_OUT"] = "Bandwidth Out: ";
L["TITAN_LATENCY_MENU_TEXT"] = "Latency";

L["TITAN_MEMORY_FORMAT"] = "%.3f".."MB";
L["TITAN_MEMORY_FORMAT_KB"] = "%d".."KB";
L["TITAN_MEMORY_RATE_FORMAT"] = "%.3f".."KB/s";
L["TITAN_MEMORY_BUTTON_LABEL"] = "Memory: ";
L["TITAN_MEMORY_TOOLTIP"] = "Memory Usage";
L["TITAN_MEMORY_TOOLTIP_CURRENT_MEMORY"] = "Current: ";
L["TITAN_MEMORY_TOOLTIP_INITIAL_MEMORY"] = "Initial: ";
L["TITAN_MEMORY_TOOLTIP_INCREASING_RATE"] = "Increasing Rate: ";
L["TITAN_MEMORY_KBMB_LABEL"] = "KB/MB";

addon.L = L
