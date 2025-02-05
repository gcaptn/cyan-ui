--!nolint LocalShadow

local Components = {}

local Packages = script.Parent.Parent
local Fusion = require(Packages.Fusion)
local Themes = require(script.Parent.Themes)
local Types = require(script.Parent.Types)

local function mapMerge(...)
	local newMap = {}
	for _, map in ipairs(table.pack(...)) do
		for k, v in pairs(map) do
			newMap[k] = v
		end
	end
	return newMap
end

local function removeProps(
	props: Fusion.PropertyTable,
	...: any
): Fusion.PropertyTable
	local newProps = table.clone(props)
	for _, property in ipairs(table.pack(...)) do
		newProps[property] = nil
	end
	return newProps
end

-- Primitives

local function computedUDim(
	scope: Fusion.Scope<any>,
	scale: Fusion.UsedAs<number>,
	offset: Fusion.UsedAs<number>
)
	return scope:Computed(function(use)
		return UDim.new(use(scale), use(offset))
	end)
end

local function computedUDim2(
	scope: Fusion.Scope<any>,
	scaleX: Fusion.UsedAs<number>,
	offsetX: Fusion.UsedAs<number>,
	scaleY: Fusion.UsedAs<number>,
	offsetY: Fusion.UsedAs<number>
)
	return scope:Computed(function(use)
		return UDim2.new(use(scaleX), use(offsetX), use(scaleY), use(offsetY))
	end)
end

function Components.Round(scope: Fusion.Scope<any>)
	return scope:New "UICorner" {
		CornerRadius = UDim.new(1, 0),
	}
end

function Components.Stroke(
	scope: Fusion.Scope<any>,
	props: Fusion.PropertyTable
): Fusion.Child
	return scope:New "UIStroke"(
		mapMerge({ ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, props)
	)
end

function Components.PadNormal(scope: Fusion.Scope<any>, _props): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local sizes = theme.Sizes

	return scope:New "UIPadding" {
		PaddingBottom = computedUDim(scope, 0, sizes.PaddingNormal),
		PaddingLeft = computedUDim(scope, 0, sizes.PaddingNormal),
		PaddingRight = computedUDim(scope, 0, sizes.PaddingNormal),
		PaddingTop = computedUDim(scope, 0, sizes.PaddingNormal),
	}
end

function Components.PadSmall(scope: Fusion.Scope<any>, _props): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local sizes = theme.Sizes

	return scope:New "UIPadding" {
		PaddingBottom = computedUDim(scope, 0, sizes.PaddingSmall),
		PaddingLeft = computedUDim(scope, 0, sizes.PaddingSmall),
		PaddingRight = computedUDim(scope, 0, sizes.PaddingSmall),
		PaddingTop = computedUDim(scope, 0, sizes.PaddingSmall),
	}
end

function Components.PadNormalSmall(
	scope: Fusion.Scope<any>,
	_props
): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local sizes = theme.Sizes

	return scope:New "UIPadding" {
		PaddingBottom = computedUDim(scope, 0, sizes.PaddingSmall),
		PaddingLeft = computedUDim(scope, 0, sizes.PaddingNormal),
		PaddingRight = computedUDim(scope, 0, sizes.PaddingNormal),
		PaddingTop = computedUDim(scope, 0, sizes.PaddingSmall),
	}
end

function Components.PadNormalLarge(
	scope: Fusion.Scope<any>,
	_props
): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local sizes = theme.Sizes

	return scope:New "UIPadding" {
		PaddingBottom = computedUDim(scope, 0, sizes.PaddingLarge),
		PaddingLeft = computedUDim(scope, 0, sizes.PaddingNormal),
		PaddingRight = computedUDim(scope, 0, sizes.PaddingNormal),
		PaddingTop = computedUDim(scope, 0, sizes.PaddingLarge),
	}
end

function Components.List(scope: Fusion.Scope<any>, _props): Fusion.Child
	return scope:New "UIListLayout" {
		SortOrder = Enum.SortOrder.LayoutOrder,
	}
end

function Components.ListPadNormal(
	scope: Fusion.Scope<any>,
	_props
): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local sizes = theme.Sizes

	return scope:New "UIListLayout" {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = computedUDim(scope, 0, sizes.PaddingNormal),
	}
end

function Components.ListPadLarge(scope: Fusion.Scope<any>, _props): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local sizes = theme.Sizes

	return scope:New "UIListLayout" {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = computedUDim(scope, 0, sizes.PaddingLarge),
	}
end

function Components.ListPadSmall(scope: Fusion.Scope<any>, _props): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local sizes = theme.Sizes

	return scope:New "UIListLayout" {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = computedUDim(scope, 0, sizes.PaddingSmall),
	}
end

function Components.ListFlexXPadSmall(
	scope: Fusion.Scope<any>,
	_props
): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local sizes = theme.Sizes

	return scope:New "UIListLayout" {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalFlex = Enum.UIFlexAlignment.Fill,
		Padding = computedUDim(scope, 0, sizes.PaddingSmall),
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
	}
end

function Components.FrameBase(scope: Fusion.Scope<any>, props): Fusion.Child
	return scope:New "Frame"(mapMerge({
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 0),
	}, props))
end

-- behaves similar to a HTML div
function Components.FrameAutoY(scope: Fusion.Scope<any>, props): Fusion.Child
	local scope = scope:innerScope {
		FrameBase = Components.FrameBase,
	}

	return scope:FrameBase(mapMerge({
		AutomaticSize = Enum.AutomaticSize.Y,
	}, props))
end

function Components.FrameAutoXY(scope: Fusion.Scope<any>, props): Fusion.Child
	local scope = scope:innerScope {
		FrameBase = Components.FrameBase,
	}

	return scope:FrameBase(mapMerge({
		AutomaticSize = Enum.AutomaticSize.XY,
	}, props))
end

-- Basic components

function Components.TextBase(scope: Fusion.Scope<any>, props): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local sizes, fonts = theme.Sizes, theme.Fonts

	return scope:New "TextLabel"(mapMerge({
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		FontFace = fonts.Body,
		Size = UDim2.fromScale(1, 0),
		TextSize = sizes.BodyText,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = "",
		TextWrapped = true,
	}, props))
end

type PrimaryOrSecondary = "Primary" | "Secondary"

-- Note: don't forget to use removeProps & always default to Primary
type PrimaryOrSecondaryProps = { Variant: PrimaryOrSecondary? }

function Components.BodyText(
	scope: Fusion.Scope<any>,
	props: PrimaryOrSecondaryProps & Fusion.PropertyTable
): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local colors = theme.Colors

	local scope = scope:innerScope {
		TextBase = Components.TextBase,
	}

	return scope:TextBase(mapMerge({
		TextColor3 = if props.Variant == "Secondary"
			then colors.FgSecondary
			else colors.Fg,
	}, removeProps(props, "Variant")))
end

function Components.HeadingText(
	scope: Fusion.Scope<any>,
	props: PrimaryOrSecondaryProps & Fusion.PropertyTable
): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local colors, sizes, fonts = theme.Colors, theme.Sizes, theme.Fonts

	local scope = scope:innerScope {
		TextBase = Components.TextBase,
	}

	return scope:TextBase(mapMerge({
		TextColor3 = if props.Variant == "Secondary"
			then colors.FgSecondary
			else colors.Fg,
		FontFace = fonts.Heading,
		TextSize = sizes.HeadingText,
	}, removeProps(props, "Variant")))
end

function Components.RowContainer(
	scope: Fusion.Scope<any>,
	props: Fusion.PropertyTable
): Fusion.Child
	local scope = scope:innerScope {
		FrameAutoY = Components.FrameAutoY,
		ListPadNormal = Components.ListPadNormal,
	}

	return scope:FrameAutoY {
		[Fusion.Children] = {
			scope:ListPadNormal {},
			props[Fusion.Children],
		},
	}
end

function Components.ErrorText(
	scope: Fusion.Scope<any>,
	props: Fusion.PropertyTable
): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local colors = theme.Colors

	local scope = scope:innerScope {
		BodyText = Components.BodyText,
	}

	return scope:BodyText(mapMerge({
		TextColor3 = colors.ErrorFg,
	}, props))
end

function Components.RowContainerPadSmall(
	scope: Fusion.Scope<any>,
	props: Fusion.PropertyTable
): Fusion.Child
	local scope = scope:innerScope {
		FrameAutoY = Components.FrameAutoY,
		ListPadSmall = Components.ListPadSmall,
	}

	return scope:FrameAutoY {
		[Fusion.Children] = {
			scope:ListPadSmall {},
			props[Fusion.Children],
		},
	}
end

function Components.RowContainerPadLarge(
	scope: Fusion.Scope<any>,
	props: Fusion.PropertyTable
): Fusion.Child
	local scope = scope:innerScope {
		FrameAutoY = Components.FrameAutoY,
		ListPadNormal = Components.ListPadNormal,
	}

	return scope:FrameAutoY {
		[Fusion.Children] = {
			scope:ListPadNormal {},
			props[Fusion.Children],
		},
	}
end

function Components.Row(
	scope: Fusion.Scope<any>,
	props: Fusion.PropertyTable
): Fusion.Child
	local scope = scope:innerScope {
		FrameAutoY = Components.FrameAutoY,
		ListFlexXPadSmall = Components.ListFlexXPadSmall,
	}

	return scope:FrameAutoY {
		[Fusion.Children] = {
			scope:ListFlexXPadSmall {},
			props[Fusion.Children],
		},
	}
end

local UI_TWEENINFO = TweenInfo.new(0.1, Enum.EasingStyle.Linear)

type GuiStateTransitions<T> = {
	Hover: Fusion.UsedAs<T>,
	Idle: Fusion.UsedAs<T>,
	Press: Fusion.UsedAs<T>,
	NonInteractable: Fusion.UsedAs<T>,
}

-- creates a Fusion tweened value for each of the Enum.GuiState states
local function createGuiTransitions<T>(
	scope: Fusion.Scope<any>,
	guiState: Fusion.UsedAs<Enum.GuiState>,
	transitions: Fusion.UsedAs<
		GuiStateTransitions<T>
	>
)
	return scope:Tween(
		scope:Computed(function(use, scope)
			local state = use(guiState)
			-- selene: allow(shadowing)
			local transitions = use(transitions)

			return if state == Enum.GuiState.Press
				then use(transitions.Press)
				elseif state == Enum.GuiState.Hover then use(
					transitions.Hover
				)
				elseif state == Enum.GuiState.NonInteractable then use(
					transitions.NonInteractable
				)
				else use(transitions.Idle)
		end),
		UI_TWEENINFO
	)
end

-- Utility for components that use BaseButton
local function createButtonTransitions(
	scope: Fusion.Scope<any>,
	buttonType: "ImageButton" | "TextButton",
	variant: PrimaryOrSecondary,
	theme: Types.Theme
)
	local colors, sizes = theme.Colors, theme.Sizes

	return if variant == "Primary"
		then {
			Button = {
				BackgroundColor3 = {
					Idle = colors.Accent,
					Hover = colors.AccentHover,
					Press = colors.AccentPressed,
					NonInteractable = colors.DisabledBg,
				},
				TextColor3 = if buttonType == "TextButton"
					then {
						Idle = colors.AccentFg,
						Hover = colors.AccentHoverFg,
						Press = colors.AccentPressedFg,
						NonInteractable = colors.DisabledFg,
					}
					else nil,
			},
			Stroke = {
				Thickness = {
					Idle = 0,
					Hover = 0,
					Press = 0,
					NonInteractable = 0,
				},
			},
		}
		else {
			Button = {
				BackgroundColor3 = {
					Idle = colors.BgSecondary,
					Hover = colors.HoverBgSecondary,
					Press = colors.PressedBgSecondary,
					NonInteractable = colors.DisabledBg,
				},
				TextColor3 = if buttonType == "TextButton"
					then {
						Idle = colors.FgSecondary,
						Hover = colors.HoverFgSecondary,
						Press = colors.PressedFgSecondary,
						NonInteractable = colors.DisabledFg,
					}
					else nil,
			},
			Stroke = {
				Thickness = {
					Idle = sizes.Border,
					Hover = sizes.Border,
					Press = sizes.Border,
					NonInteractable = 0,
				},
				Color = {
					Idle = colors.Border,
					Hover = colors.Border,
					Press = colors.Border,
					NonInteractable = colors.Border,
				},
			},
		}
end

function Components.ButtonBase(
	scope: Fusion.Scope<any>,
	props: {
		ClassName: "TextButton" | "ImageButton",
		Transitions: {
			Button: { [string]: GuiStateTransitions<any> },
			Stroke: { [string]: GuiStateTransitions<any> },
		},
		ButtonProps: Fusion.PropertyTable,
	}
): Fusion.Child
	local scope = scope:innerScope {
		Stroke = Components.Stroke,
	}

	local initiallyInteractable = Fusion.peek(props.ButtonProps.Interactable)

	-- No need for a computed value, the button's OnChange sets this value
	local buttonState = scope:Value(
		if initiallyInteractable == nil
				or initiallyInteractable == true
			then Enum.GuiState.Idle
			else Enum.GuiState.NonInteractable
	)

	local transitionProperties = {}

	for component, _ in pairs(props.Transitions) do
		transitionProperties[component] = {}
		for property, _ in pairs(props.Transitions[component]) do
			transitionProperties[component][property] = createGuiTransitions(
				scope,
				buttonState,
				props.Transitions[component][property]
			)
		end
	end

	-- is this safe?
	local onGuiStateChangeProp = Fusion.OnChange "GuiState"

	return scope:New(props.ClassName)(
		mapMerge(
			{
				AutomaticSize = Enum.AutomaticSize.XY,
				Size = UDim2.new(1, 0, 0, 0),
				[onGuiStateChangeProp] = function(value)
					buttonState:set(value)
					if
						props.ButtonProps
						and props.ButtonProps[onGuiStateChangeProp]
					then
						props.ButtonProps[onGuiStateChangeProp](value)
					end
				end,
				[Fusion.Children] = {
					scope:Stroke(transitionProperties.Stroke),
					props.ButtonProps[Fusion.Children],
				},
			},
			transitionProperties.Button,
			removeProps(
				props.ButtonProps or {},
				onGuiStateChangeProp,
				Fusion.Children
			)
		)
	) :: GuiButton
end

function Components.TextButton(
	scope: Fusion.Scope<any>,
	props: PrimaryOrSecondaryProps & Fusion.PropertyTable
): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local sizes, fonts = theme.Sizes, theme.Fonts

	local scope = scope:innerScope {
		ButtonBase = Components.ButtonBase,
		PadSmall = Components.PadSmall,
	}

	local transitions = createButtonTransitions(
		scope,
		"TextButton",
		props.Variant or "Primary",
		theme
	)

	return scope:ButtonBase {
		ClassName = "TextButton",
		Transitions = transitions,
		ButtonProps = mapMerge(
			{
				FontFace = fonts.Button,
				TextSize = sizes.BodyText,
			},
			removeProps(props, "Variant"),
			{
				[Fusion.Children] = {
					scope:PadSmall {},
					props[Fusion.Children],
				},
			}
		),
	}
end

function Components.CheckboxButton(
	scope: Fusion.Scope<any>,
	props: {
		Value: Fusion.UsedAs<boolean>,
		Interactable: Fusion.UsedAs<boolean>?,
		OnClick: Fusion.UsedAs<nil | () -> unknown?>,
	}
): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local sizes, fonts = theme.Sizes, theme.Fonts

	local scope = scope:innerScope {
		ButtonBase = Components.ButtonBase,
		FrameAutoXY = Components.FrameAutoXY,
	}

	local function handleClick()
		local onClick = Fusion.peek(props.OnClick)
		if onClick then
			onClick()
		end
	end

	local checkedButton = scope:ButtonBase {
		ClassName = "TextButton",
		Transitions = createButtonTransitions(
			scope,
			"TextButton",
			"Primary",
			theme
		),
		ButtonProps = {
			Interactable = props.Interactable,
			Text = "✓",
			TextSize = sizes.BodyText,
			FontFace = fonts.Body,
			Visible = props.Value,
			Size = computedUDim2(
				scope,
				0,
				sizes.NormalIcon,
				0,
				sizes.NormalIcon
			),
			[Fusion.OnEvent "Activated"] = handleClick,
		},
	} :: GuiButton

	local uncheckedButton = scope:ButtonBase {
		ClassName = "TextButton",
		Transitions = createButtonTransitions(
			scope,
			"TextButton",
			"Secondary",
			theme
		),
		ButtonProps = {
			Interactable = props.Interactable,
			Text = "",
			Visible = scope:Computed(function(use)
				return not use(props.Value)
			end),
			Size = computedUDim2(
				scope,
				0,
				sizes.NormalIcon,
				0,
				sizes.NormalIcon
			),
			[Fusion.OnEvent "Activated"] = handleClick,
		},
	} :: GuiButton

	return scope:FrameAutoXY {
		[Fusion.Children] = {
			uncheckedButton,
			checkedButton,
		},
	}
end

function Components.RadioButton(
	scope: Fusion.Scope<any>,
	props: {
		Value: Fusion.UsedAs<boolean>,
		Interactable: Fusion.UsedAs<boolean>?,
		OnClick: Fusion.UsedAs<nil | () -> unknown?>,
	}
): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local colors, sizes = theme.Colors, theme.Sizes

	local scope = scope:innerScope {
		ButtonBase = Components.ButtonBase,
		FrameAutoXY = Components.FrameAutoXY,
		Round = Components.Round,
	}

	return scope:FrameAutoXY {
		[Fusion.Children] = {
			scope:ButtonBase {
				ClassName = "ImageButton",
				Transitions = createButtonTransitions(
					scope,
					"ImageButton",
					"Secondary",
					theme
				),
				ButtonProps = {
					Interactable = props.Interactable,
					BorderSizePixel = 1,
					Size = computedUDim2(
						scope,
						0,
						sizes.NormalIcon,
						0,
						sizes.NormalIcon
					),
					[Fusion.Children] = {
						scope:Round {},
						scope:New "Frame" {
							BackgroundColor3 = scope:Tween(
								scope:Computed(function(use)
									local disabled = if props.Interactable
											~= nil
										then not use(props.Interactable)
										else false
									return if disabled
										then use(colors.DisabledFg)
										else use(colors.Accent)
								end),
								UI_TWEENINFO
							),
							BorderSizePixel = 0,
							Size = scope:Computed(function(use)
								return UDim2.fromOffset(
									0.5 * use(sizes.NormalIcon),
									0.5 * use(sizes.NormalIcon)
								)
							end),
							Visible = props.Value,
							AnchorPoint = Vector2.new(0.5, 0.5),
							Position = UDim2.fromScale(0.5, 0.5),
							[Fusion.Children] = {
								scope:Round {},
							},
						},
					},
				},
			},
		},
	}
end

function Components.Checkbox(
	scope: Fusion.Scope<any>,
	props: {
		Label: Fusion.UsedAs<string>,
		Value: Fusion.UsedAs<boolean>,
		Interactable: Fusion.UsedAs<boolean>?,
		OnChange: Fusion.UsedAs<nil | (value: boolean) -> unknown?>,
	}
): Fusion.Child
	local scope = scope:innerScope {
		Row = Components.Row,
		CheckboxButton = Components.CheckboxButton,
		BodyText = Components.BodyText,
	}

	return scope:Row {
		[Fusion.Children] = {
			scope:CheckboxButton {
				Value = props.Value,
				Interactable = props.Interactable,
				OnClick = function()
					local onChange = Fusion.peek(props.OnChange)
					if onChange then
						onChange(not Fusion.peek(props.Value))
					end
				end,
			},
			scope:BodyText { Text = props.Label },
		},
	}
end

function Components.Radio(
	scope: Fusion.Scope<any>,
	props: {
		Label: Fusion.UsedAs<string>,
		Value: Fusion.UsedAs<boolean>,
		Interactable: Fusion.UsedAs<boolean>?,
		OnChange: Fusion.UsedAs<nil | (value: boolean) -> unknown?>,
	}
): Fusion.Child
	local scope = scope:innerScope {
		Row = Components.Row,
		CheckboxButton = Components.CheckboxButton,
		BodyText = Components.BodyText,
	}

	return scope:Row {
		[Fusion.Children] = {
			scope:RadioButton {
				Value = props.Value,
				Interactable = props.Interactable,
				OnClick = function()
					local onChange = Fusion.peek(props.OnChange)
					if onChange then
						onChange(not Fusion.peek(props.Value))
					end
				end,
			},
			scope:BodyText { Text = props.Label },
		},
	}
end

-- uncontrolled
function Components.TextInput(
	scope: Fusion.Scope<any>,
	props: {
		OnChange: Fusion.UsedAs<nil | (text: string) -> unknown?>,
		Interactable: Fusion.UsedAs<boolean>?,
		Error: Fusion.UsedAs<boolean>?,
		HelperText: Fusion.UsedAs<string>?,
	} & Fusion.PropertyTable
): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local colors, sizes, fonts = theme.Colors, theme.Sizes, theme.Fonts
	local scope = scope:innerScope {
		PadSmall = Components.PadSmall,
		RowContainerPadSmall = Components.RowContainerPadSmall,
		ErrorText = Components.ErrorText,
		Stroke = Components.Stroke,
	}

	local isFocused = scope:Value(false)

	return scope:RowContainerPadSmall {
		[Fusion.Children] = {
			scope:New "TextBox"(mapMerge(
				{
					TextColor3 = scope:Tween(
						scope:Computed(function(use, scope)
							local disabled = if props.Interactable ~= nil
								then use(props.Interactable)
								else false

							return if disabled
								then use(colors.DisabledFg)
								else use(colors.FgSecondary)
						end),
						UI_TWEENINFO
					),
					PlaceholderColor3 = scope:Tween(
						scope:Computed(function(use, scope)
							local disabled = if props.Interactable ~= nil
								then not use(props.Interactable)
								else false

							return if disabled
								then use(colors.DisabledPlaceholderFg)
								else use(colors.DisabledPlaceholderFg)
						end),
						UI_TWEENINFO
					),
					BackgroundColor3 = scope:Tween(
						scope:Computed(function(use, scope)
							local disabled = if props.Interactable ~= nil
								then not use(props.Interactable)
								else false

							return if disabled
								then use(colors.DisabledBg)
								else use(colors.BgSecondary)
						end),
						UI_TWEENINFO
					),
					ClearTextOnFocus = false,
					CursorPosition = -1,
					FontFace = fonts.Body,
					PlaceholderText = "Type here...",
					Size = UDim2.new(1, 0, 0, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					TextSize = sizes.BodyText,
					TextXAlignment = Enum.TextXAlignment.Left,
					Interactable = props.Interactable,
					-- TextEditable = props.Interactable -- readonly inputs are possible without being disabled
					[Fusion.OnChange "Text"] = function(value)
						local onChange = Fusion.peek(props.OnChange)
						if onChange then
							onChange(value)
						end
					end,
					[Fusion.OnEvent "Focused"] = function()
						isFocused:set(true)
					end,
					[Fusion.OnEvent "FocusLost"] = function()
						isFocused:set(false)
					end,
				},
				removeProps(props, "OnChange", "HelperText", "Error", "Text"),
				{
					[Fusion.Children] = {
						scope:PadSmall {},
						scope:Stroke {
							Color = scope:Tween(
								scope:Computed(function(use, scope)
									return if use(props.Error)
										then use(colors.ErrorFg)
										else if use(isFocused)
											then use(colors.Accent)
											else use(colors.Border)
								end),
								UI_TWEENINFO
							),
							Thickness = scope:Tween(
								scope:Computed(function(use, scope)
									local disabled = if props.Interactable
											~= nil
										then not use(props.Interactable)
										else false

									return if disabled -- Disabled
										then 0
										else use(sizes.Border)
								end),
								UI_TWEENINFO
							),
						},
						props[Fusion.Children],
					},
				}
			)),
			scope:Computed(function(use)
				local helperText = use(props.HelperText)

				return if not helperText
					then nil
					else if use(props.Error)
						then scope:ErrorText { Text = helperText }
						else scope:BodyText { Text = helperText }
			end),
		},
	}
end

function Components.ScrollFrame(
	scope: Fusion.Scope<any>,
	props: Fusion.PropertyTable
): Fusion.Child
	local theme = Themes.ThemeContext:now()
	local colors, sizes = theme.Colors, theme.Sizes

	local scope = scope:innerScope {
		List = Components.List,
		FrameAutoY = Components.FrameAutoY,
	}

	return scope:New "ScrollingFrame" {
		Active = true,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = colors.BgSecondary,
		BorderSizePixel = 0,
		CanvasSize = scope:Computed(function(use)
			return UDim2.new(0, -use(sizes.ScrollBar), 1, 0)
		end),
		ScrollBarImageColor3 = colors.FgSecondary,
		ScrollBarThickness = sizes.ScrollBar,
		Size = UDim2.fromScale(1, 1),
		[Fusion.Children] = {
			scope:FrameAutoY {
				BackgroundColor3 = colors.Bg,
				BorderSizePixel = 0,
				BackgroundTransparency = 0,
				Size = scope:Computed(function(use)
					return UDim2.new(1, -use(sizes.ScrollBar), 1, 0)
				end),
				[Fusion.Children] = {
					scope:List {},
					props[Fusion.Children],
				},
			},
		},
	}
end

local function CollapsibleHeader(
	scope: Fusion.Scope<any>,
	props: {
		isCollapsed: Fusion.UsedAs<boolean>,
		Label: Fusion.UsedAs<string>,
	}
)
	local theme = Themes.ThemeContext:now()
	local colors, sizes = theme.Colors, theme.Sizes

	local scope = scope:innerScope {
		ButtonBase = Components.ButtonBase,
		List = Components.List,
		HeadingText = Components.HeadingText,
		PadNormalSmall = Components.PadNormalSmall,
	}

	return scope:ButtonBase {
		ClassName = "TextButton",
		Transitions = createButtonTransitions(
			scope,
			"TextButton",
			"Secondary",
			theme
		),
		ButtonProps = {
			Text = "",
			BorderColor3 = colors.Border,
			BorderSizePixel = sizes.Border,
			BorderMode = Enum.BorderMode.Outline,
			[Fusion.OnEvent "Activated"] = function()
				props.isCollapsed:set(not Fusion.peek(props.isCollapsed))
			end,
			[Fusion.Children] = {
				scope:PadNormalSmall {},
				scope:HeadingText {
					Variant = "Secondary",
					Text = props.Label,
				},
				-- Icon
				scope:HeadingText {
					Variant = "Secondary",
					Text = scope:Computed(function(use, scope)
						return if use(props.isCollapsed) then "+" else "–"
					end),
					TextXAlignment = Enum.TextXAlignment.Right,
				},
			},
		},
	}
end

-- uncontrolled
function Components.Collapsible(
	scope: Fusion.Scope<any>,
	props: {
		InitiallyCollapsed: Fusion.UsedAs<boolean>?,
		Label: Fusion.UsedAs<string>,
	} & Fusion.PropertyTable
)
	local scope = scope:innerScope {
		List = Components.List,
		FrameAutoY = Components.FrameAutoY,
		FrameBase = Components.FrameBase,
		PadNormalLarge = Components.PadNormalLarge,
		CollapsibleHeader = CollapsibleHeader,
	}

	local isCollapsed =
		scope:Value(Fusion.peek(props.InitiallyCollapsed) or false)

	return scope:FrameAutoY {
		[Fusion.Children] = {
			scope:List {},
			-- Header
			scope:CollapsibleHeader {
				Label = props.Label,
				isCollapsed = isCollapsed,
			},
			-- Body
			scope:FrameAutoY {
				Visible = scope:Computed(function(use, scope)
					return not use(isCollapsed)
				end),
				[Fusion.Children] = {
					scope:PadNormalLarge {},
					props[Fusion.Children],
				},
			},
		},
	}
end

return Components
