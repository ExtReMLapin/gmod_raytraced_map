local minimap_x = 100
local minimap_y = 100
local minimap_w = 100
local minimap_h = 100
local density_ui = 10
local density = 60
local height = 500


local matstruct = {

	{MAT_ANTLION , Color(244, 244, 66)},
	{MAT_BLOODYFLESH , Color(155, 0, 0)},
	{MAT_CONCRETE , Color(109, 109, 109)},
	{MAT_DIRT , Color(79, 40, 0)},
	{MAT_EGGSHELL , Color(178, 83, 123)},
	{MAT_FLESH , Color(178, 35, 57)},
	{MAT_GRATE , Color(165, 165, 165)},
	{MAT_ALIENFLESH , Color(0, 114, 30)},
	{MAT_CLIP , Color(33, 33, 33)},
	{MAT_SNOW , Color(240, 240, 240)},
	{MAT_PLASTIC , Color(00, 22, 91)},
	{MAT_METAL , Color(124, 124, 124)},
	{MAT_SAND , Color(204, 172, 106)},
	{MAT_FOLIAGE , Color(0, 91, 5)},
	{MAT_COMPUTER , Color(132, 132, 132)},
	{MAT_SLOSH , Color(73, 49, 42)},
	{MAT_TILE , Color(0, 204, 180)},
	{MAT_GRASS , Color(0, 168, 5)},
	{MAT_VENT , Color(86, 86, 86)},
	{MAT_WOOD , Color(86, 67, 31)},
	{MAT_DEFAULT , Color(255, 255, 255)},
	{MAT_GLASS , Color(200, 200, 255)},
	{MAT_WARPSHIELD , Color(0, 255, 255)}
}

hook.Add("HUDPaint", "minimap", function()
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(minimap_x - 1, minimap_y - 1, minimap_w * density_ui + 2, minimap_h * density_ui + 2)
	local x = 0
	local top_pos = LocalPlayer():GetPos() + Vector(-(minimap_w / 2 * density), -(minimap_h / 2 * density), height)

	while (x < minimap_w) do
		local y = 0

		while (y < minimap_h) do
			local tr = util.TraceLine({
				start = top_pos + Vector(x * density, y * density, 0),
				endpos = top_pos + Vector(0, 0, -10000000)
			})

			if (tr.Hit) then
				local mat = tr.MatType
				local col = color_white

				for k, v in pairs(matstruct) do
					if v[1] == mat then
						col = v[2]
						break
					end
				end

				surface.SetDrawColor(col)
				surface.DrawRect(minimap_x + (minimap_w * density_ui) - x * density_ui - density_ui, minimap_y + y * density_ui, density_ui, density_ui)
			end

			y = y + 1
		end

		x = x + 1
	end
end)