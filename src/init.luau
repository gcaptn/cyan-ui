local Themes = require(script.Themes)
local Components = require(script.Components)
local Types = require(script.Types)

export type ColorScale = Types.ColorScale
export type ThemeColorsSpec = Types.ThemeColorsSpec
export type ThemeSizesSpec = Types.ThemeSizesSpec
export type ThemeFontsSpec = Types.ThemeFontsSpec
export type ThemeSpec = Types.ThemeSpec

return {
	Themes = Themes,
	Components = Components,
}
