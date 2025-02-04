local Packages = script.Parent.Packages
local Fusion = require(Packages.Fusion)
local App = require(script.Parent.App)

return function(target)
	local scope = Fusion.scoped(Fusion, { App = App })

	scope:New "Frame" {
		Parent = target,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Size = UDim2.new(0, 320, 0.9, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		[Fusion.Children] = {
			scope:App {},
		},
	}

	return function()
		scope:doCleanup()
	end
end
