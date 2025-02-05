-- TODO: use story controls

local Packages = script.Parent.Parent
local Fusion = require(Packages.Fusion)
local CyanUI = require(script.Parent)

local LIPSUM =
	"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness."

-- Unaffected by theme context
local function UnaffectedByTheme(scope: Fusion.Scope<any>)
	local scope = scope:innerScope(CyanUI.Components)
	local theme = scope:Value "Light"

	local themeSpec = scope:Computed(function(use)
		return if use(theme) == "Light"
			then CyanUI.Themes.DefaultTheme.Light
			else CyanUI.Themes.DefaultTheme.Dark
	end)
	local dynamicTheme = CyanUI.Themes.CreateDynamicTheme(scope, themeSpec)

	local function toggleTheme()
		theme:set(if Fusion.peek(theme) == "Light" then "Dark" else "Light")
	end

	return scope:RowContainer {
		[Fusion.Children] = {
			CyanUI.Themes.ThemeContext:is(dynamicTheme):during(function()
				return {
					scope:HeadingText { Text = "Unaffected by Theme Context" },
					scope:BodyText { Text = LIPSUM },
					scope:TextButton {
						Text = "Switch theme",
						Variant = "Secondary",
						[Fusion.OnEvent "Activated"] = toggleTheme,
					},
				}
			end),
		},
	}
end

return function(target)
	local scope = Fusion.scoped(
		Fusion,
		CyanUI.Components,
		{ UnaffectedByTheme = UnaffectedByTheme }
	)

	scope:New "Frame" {
		Parent = target,
		Size = UDim2.new(0, 320, 0.9, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		BackgroundColor3 = Color3.new(1, 1, 1),
		[Fusion.Children] = {
			scope:ScrollFrame {
				[Fusion.Children] = {
					scope:Collapsible {
						Label = "Collapsible",
						[Fusion.Children] = {
							scope:RowContainer {
								[Fusion.Children] = {
									-- Typography
									scope:HeadingText { Text = "Typography" },
									scope:BodyText { Text = LIPSUM },
									scope:HeadingText { Text = "Error Text" },
									scope:ErrorText { Text = LIPSUM },
									-- Theme Context
									scope:UnaffectedByTheme {},
									-- Buttons
									scope:HeadingText { Text = "Buttons" },
									scope:TextButton { Text = "Primary" },
									scope:TextButton {
										Variant = "Secondary",
										Text = "Secondary",
									},
									scope:TextButton {
										Variant = "Secondary",
										Text = "Disabled",
										Interactable = false,
									},
									-- Text Input
									scope:HeadingText { Text = "Text Input" },
									scope:TextInput {
										PlaceholderText = "Single-line input...",
										HelperText = "Helper text",
									},
									scope:TextInput {
										PlaceholderText = "Disabled input...",
										Interactable = false,
									},
									scope:TextInput {
										PlaceholderText = "With validation...",
										Error = true,
										HelperText = "Error text",
									},
									scope:TextInput {
										TextWrapped = true,
										MultiLine = true,
										PlaceholderText = "Multi-line input...",
									},

									-- Rows
									scope:HeadingText { Text = "Rows" },
									scope:Row {
										[Fusion.Children] = {
											scope:TextInput {},
											scope:Row {
												[Fusion.Children] = {
													scope:TextButton {
														Variant = "Primary",
														Text = "Primary",
													},
													scope:TextButton {
														Variant = "Secondary",
														Text = "Secondary",
													},
												},
											},
										},
									},
									-- Checkboxes
									scope:HeadingText { Text = "Checkboxes" },
									scope:Checkbox {
										Label = "With label",
										Value = true,
										Interactable = false,
									},
									scope:Row {
										[Fusion.Children] = {
											scope:CheckboxButton { Value = true },
											scope:CheckboxButton {
												Value = false,
											},
											scope:CheckboxButton {
												Value = true,
												Interactable = false,
											},
											scope:CheckboxButton {
												Value = false,
												Interactable = false,
											},
										},
									},
									-- Radio
									scope:HeadingText { Text = "Radio" },
									scope:Radio {
										Label = "With label",
										Value = true,
										Interactable = false,
									},
									scope:Row {
										[Fusion.Children] = {
											scope:RadioButton { Value = true },
											scope:RadioButton {
												Value = false,
											},
											scope:RadioButton {
												Value = true,
												Interactable = false,
											},
											scope:RadioButton {
												Value = false,
												Interactable = false,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
	}

	-- Flash theme
	local flashingTheme = true
	local dark = false

	task.spawn(function()
		while flashingTheme do
			task.wait(2)
			dark = not dark
			CyanUI.Themes.GlobalThemeSpec:set(
				if dark
					then CyanUI.Themes.DefaultTheme.Dark
					else CyanUI.Themes.DefaultTheme.Light
			)
		end
	end)

	return function()
		flashingTheme = false
		scope:doCleanup()
	end
end
