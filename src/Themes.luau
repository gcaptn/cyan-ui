--!strict
--!nolint LocalShadow

local Themes = {}

local Packages = script.Parent.Parent
local Fusion = require(Packages.Fusion)
local TailwindColors = require(Packages.TailwindColors)
local Types = require(script.Parent.Types)

local DEFAULT_GRAY_SCALE = TailwindColors.neutral
local DEFAULT_RED_SCALE = TailwindColors.red

-- Tailwind-compatible palette generator: https://uicolors.app/create

local DEFAULT_THEME_COLOR_SCALE: TailwindColors.ColorScale = {
	["50"] = Color3.fromHex "#eefdfd",
	["100"] = Color3.fromHex "#d3f8fa",
	["200"] = Color3.fromHex "#adf1f4",
	["300"] = Color3.fromHex "#75e5eb",
	["400"] = Color3.fromHex "#35cedb",
	["500"] = Color3.fromHex "#19b1c1",
	["600"] = Color3.fromHex "#1996aa", -- primary: RGB 25, 150, 170
	["700"] = Color3.fromHex "#1a7384",
	["800"] = Color3.fromHex "#1e5d6c",
	["900"] = Color3.fromHex "#1d4f5c",
	["950"] = Color3.fromHex "#0e343e",
}

-- TODO: Use rem units & base sizes
local DEFAULT_SIZES: Types.ThemeSizesSpec = {
	Border = 1,
	ScrollBar = 8,
	BodyText = 16,
	HeadingText = 18,
	PaddingSmall = 6,
	PaddingNormal = 12,
	PaddingLarge = 16,
	NormalIcon = 18, -- Radio/checkbox
	LargeIcon = 28,
}

local DEFAULT_TYPEFACE = "rbxasset://fonts/families/SourceSansPro.json"

local DEFAULT_FONTS: Types.ThemeFontsSpec = {
	Heading = Font.new(DEFAULT_TYPEFACE, Enum.FontWeight.Bold),
	Body = Font.new(DEFAULT_TYPEFACE, Enum.FontWeight.Medium),
	Button = Font.new(DEFAULT_TYPEFACE, Enum.FontWeight.Bold),
}

--[[
	Generates a standard ThemeSpec from Tailwind color scales
]]
function Themes.ThemeSpecFromThemeColorScale(
	background: "Light" | "Dark",
	themeColorScale: TailwindColors.ColorScale?,
	grayScale: TailwindColors.ColorScale?,
	redScale: TailwindColors.ColorScale?
): Types.ThemeSpec
	-- selene: allow(shadowing)
	local themeColorScale = themeColorScale or DEFAULT_THEME_COLOR_SCALE
	-- selene: allow(shadowing)
	local grayScale = grayScale or DEFAULT_GRAY_SCALE
	-- selene: allow(shadowing)
	local redScale = redScale or DEFAULT_RED_SCALE

	local colors = if background == "Light"
		then {
			Bg = TailwindColors.white,
			Fg = grayScale["800"],
			Border = grayScale["300"],
			BgSecondary = grayScale["200"],
			FgSecondary = grayScale["950"],
			PlaceholderFg = grayScale["500"],
			HoverBgSecondary = grayScale["300"],
			HoverFgSecondary = grayScale["900"],
			PressedBgSecondary = grayScale["100"],
			PressedFgSecondary = grayScale["950"],
			DisabledBg = grayScale["300"],
			DisabledFg = grayScale["400"],
			DisabledPlaceholderFg = grayScale["400"],
			ErrorFg = redScale["500"],
			Accent = themeColorScale["500"],
			AccentFg = TailwindColors.white,
			AccentHover = themeColorScale["600"],
			AccentHoverFg = themeColorScale["100"],
			AccentPressed = themeColorScale["400"],
			AccentPressedFg = TailwindColors.white,
		}
		else { -- Dark mode
			Bg = grayScale["700"],
			Fg = grayScale["200"],
			Border = grayScale["950"],
			BgSecondary = grayScale["800"],
			FgSecondary = grayScale["50"],
			PlaceholderFg = grayScale["600"],
			HoverBgSecondary = grayScale["900"],
			HoverFgSecondary = grayScale["200"],
			PressedBgSecondary = grayScale["700"],
			PressedFgSecondary = grayScale["50"],
			DisabledBg = grayScale["600"],
			DisabledFg = grayScale["500"],
			DisabledPlaceholderFg = grayScale["500"],
			ErrorFg = redScale["500"],
			Accent = themeColorScale["600"],
			AccentFg = themeColorScale["50"],
			AccentHover = themeColorScale["700"],
			AccentHoverFg = themeColorScale["100"],
			AccentPressed = themeColorScale["500"],
			AccentPressedFg = themeColorScale["50"],
		}

	return {
		Colors = colors,
		Sizes = DEFAULT_SIZES,
		Fonts = DEFAULT_FONTS,
	}
end

--[[
	Generates a dynamic computed theme from a ThemeSpec value, for use 
	as a ThemeContext value.

	Example usage:
	
		local themeSpec = scope:Value(Themes.DefaultTheme.Light)
		local dynamicTheme = Themes.CreateDynamicTheme(scope, themeSpec)
		
		Theme:is(dynamicTheme):during(function()
			-- ...
		end)
		
		themeSpec:set(Themes.DefaultTheme.Dark)
]]
function Themes.CreateDynamicTheme(
	scope: Fusion.Scope<any>,
	themeSpec: Fusion.UsedAs<Types.ThemeSpec>
)
	local theme = {}

	for k, map in pairs(Fusion.peek(themeSpec)) do
		local newMap = {}
		for variable, _ in pairs(map) do
			newMap[variable] = scope:Computed(function(use)
				return use(themeSpec)[k][variable]
			end)
		end
		theme[k] = newMap
	end

	return theme :: Types.Theme
end

Themes.DefaultTheme = {
	Light = Themes.ThemeSpecFromThemeColorScale "Light",
	Dark = Themes.ThemeSpecFromThemeColorScale "Dark",
}

local scope = Fusion.scoped(Fusion)

Themes.GlobalThemeSpec = scope:Value(Themes.DefaultTheme.Light)

Themes.ThemeContext =
	Fusion.Contextual(Themes.CreateDynamicTheme(scope, Themes.GlobalThemeSpec))

return Themes
