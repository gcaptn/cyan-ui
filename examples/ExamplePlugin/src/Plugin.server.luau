local Packages = script.Parent.Packages
local Fusion = require(Packages.Fusion)
local CyanUI = require(Packages.CyanUI)
local App = require(script.Parent.App)

-- Plugin toolbar & widget

local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float, -- Widget will be initialized in floating panel
	false, -- Widget will be initially enabled
	false, -- Don't override the previous enabled state
	320, -- Default width of the floating window
	400, -- Default height of the floating window
	300, -- Minimum width of the floating window
	200 -- Minimum height of the floating window
)

local widget = plugin:CreateDockWidgetPluginGui("get", widgetInfo)
widget.Title = "Example Plugin"

local toolbar = plugin:CreateToolbar "Example Plugin"
local pluginButton = toolbar:CreateButton(
	"Example Plugin",
	"Example plugin made with CyanUI",
	""
)

pluginButton.Click:Connect(function()
	widget.Enabled = not widget.Enabled
end)

-- Render app with theme

local scope = Fusion.scoped(Fusion, CyanUI.Components, { App = App })

local themeName = scope:Value(settings().Studio.Theme.Name)

settings().Studio.ThemeChanged:Connect(function()
	themeName:set(settings().Studio.Theme.Name)
end)

local themeSpec = scope:Computed(function(use)
	return if use(themeName) == "Light"
		then CyanUI.Themes.DefaultTheme.Light
		else CyanUI.Themes.DefaultTheme.Dark
end)

local dynamicTheme = CyanUI.Themes.CreateDynamicTheme(scope, themeSpec)

local app = CyanUI.Themes.ThemeContext:is(dynamicTheme):during(function()
	return scope:App {}
end)

app.Parent = widget
