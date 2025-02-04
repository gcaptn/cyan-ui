-- Note: Don't forget to export all types in init.luau and standalone/init.luau

local Packages = script.Parent.Parent
local Fusion = require(Packages.Fusion)
local TailwindColors = require(Packages.TailwindColors)

-- THEMING

export type ColorScale = TailwindColors.ColorScale

type UsedAsColor3 = Fusion.UsedAs<Color3>
type UsedAsFont = Fusion.UsedAs<Font>
type UsedAsNumber = Fusion.UsedAs<number>

--[[
Token naming:
Component (or color) hierarchy -> Color variant (secondary/primary) -> State -> Repeat
TODO: Use Material Design token names
]]
type ThemeColorsKeys<T> = {
	Bg: T, -- Is actually "MainBg" with "Main" as component, omitted for brevity
	Fg: T,
	Border: T,
	BgSecondary: T,
	FgSecondary: T,
	PlaceholderFg: T,
	HoverBgSecondary: T,
	HoverFgSecondary: T,
	PressedBgSecondary: T,
	PressedFgSecondary: T,
	DisabledBg: T,
	DisabledFg: T,
	DisabledPlaceholderFg: T,
	-- WarningBg: T,
	-- WarningFg: T,
	-- ErrorBg: T,
	ErrorFg: T,
	Accent: T,
	AccentFg: T, -- Primary buttons
	AccentHover: T,
	AccentHoverFg: T,
	AccentPressed: T,
	AccentPressedFg: T,
}

export type ThemeColorsSpec = ThemeColorsKeys<Color3>

type ThemeSizesKeys<T> = {
	Border: T,
	ScrollBar: T,
	BodyText: T,
	HeadingText: T,
	PaddingSmall: T,
	PaddingNormal: T,
	PaddingLarge: T,
	NormalIcon: T,
	LargeIcon: T,
}

export type ThemeSizesSpec = ThemeSizesKeys<number>

type ThemeFontsKeys<T> = {
	Heading: T,
	Body: T,
	Button: T,
}

export type ThemeFontsSpec = ThemeFontsKeys<Font>

type ThemeKeys<C, S, F> = {
	Colors: ThemeColorsKeys<C>,
	Sizes: ThemeSizesKeys<S>,
	Fonts: ThemeFontsKeys<F>,
}

export type ThemeSpec = ThemeKeys<Color3, number, Font>
export type Theme = ThemeKeys<UsedAsColor3, UsedAsNumber, UsedAsFont>

return {}
