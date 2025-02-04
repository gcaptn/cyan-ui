local Packages = script.Parent.Packages
local Fusion = require(Packages.Fusion)
local CyanUI = require(Packages.CyanUI)

return function(scope: Fusion.Scope<any>, _props)
	local scope = Fusion.scoped(Fusion, CyanUI.Components)
	local count = scope:Value(0)

	return scope:ScrollFrame {
		[Fusion.Children] = {
			scope:Collapsible {
				Label = "Counter",
				[Fusion.Children] = {
					scope:RowContainerPadLarge {
						[Fusion.Children] = {
							scope:HeadingText { Text = "Counter" },
							scope:BodyText {
								Text = scope:Computed(function(use)
									return "Count: " .. use(count)
								end),
							},
							scope:TextButton {
								Text = "Increment",
								[Fusion.OnEvent "Activated"] = function()
									count:set(Fusion.peek(count) + 1)
								end,
							},
						},
					},
				},
			},
		},
	}
end
