local minimap_x = 0
local minimap_y = 0
local minimap_w = 40
local minimap_h = 40
local density_ui = 20
local distance = 10
local height = 500


local matstruct = {}
matstruct[MAT_ANTLION] = Color(244, 244, 66)
matstruct[MAT_BLOODYFLESH] = Color(155, 0, 0)
matstruct[MAT_CONCRETE] = Color(109, 109, 109)
matstruct[MAT_DIRT] = Color(79, 40, 0)
matstruct[MAT_EGGSHELL] = Color(178, 83, 123)
matstruct[MAT_FLESH] = Color(178, 35, 57)
matstruct[MAT_GRATE] = Color(165, 165, 165)
matstruct[MAT_ALIENFLESH] = Color(0, 114, 30)
matstruct[MAT_CLIP] = Color(33, 33, 33)
matstruct[MAT_SNOW] = Color(240, 240, 240)
matstruct[MAT_PLASTIC] = Color(00, 22, 91)
matstruct[MAT_METAL] = Color(124, 124, 124)
matstruct[MAT_SAND] = Color(204, 172, 106)
matstruct[MAT_FOLIAGE] = Color(0, 91, 5)
matstruct[MAT_COMPUTER] = Color(132, 132, 132)
matstruct[MAT_SLOSH] = Color(73, 49, 42)
matstruct[MAT_TILE] = Color(0, 204, 180)
matstruct[MAT_GRASS] = Color(0, 168, 5)
matstruct[MAT_VENT] = Color(86, 86, 86)
matstruct[MAT_WOOD] = Color(86, 67, 31)
matstruct[MAT_DEFAULT] = Color(255, 255, 255)
matstruct[MAT_GLASS] = Color(200, 200, 255)
matstruct[MAT_WARPSHIELD] = Color(0, 255, 255)


local function rotatePoint(x1, y1, centerx, centery, angle)
	angle = math.rad(angle)
	local rotatedX = math.cos(angle) * (x1 - centerx) - math.sin(angle) * (y1 - centery) + centerx
	local rotatedY = math.sin(angle) * (x1 - centerx) + math.cos(angle) * (y1 - centery) + centery

	return rotatedX, rotatedY
end



hook.Add("HUDPaint", "minimap", function()

	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(minimap_x - 1, minimap_y - 1, minimap_w * density_ui + 2, minimap_h * density_ui + 2)
	local x = 0
	local top_pos = LocalPlayer():GetPos() + Vector(-(minimap_w / 2 * distance), -(minimap_h / 2 * distance), height)
	local playerangle = LocalPlayer():EyeAngles().y + 90

	--local playeranglerad = math.rad(playerangle)
	while (x < minimap_w) do
		local y = 0

		while (y < minimap_h) do
			local xpos = x * distance
			local ypos = y * distance

			local x2 , y2 = rotatePoint(xpos, ypos, minimap_w / 2 * distance , minimap_h / 2 * distance, playerangle)
			local start = Vector(x2, y2, 0)

			local endpos = Vector(0, 0, -10000000)
			start:Add(top_pos)
			endpos:Add(top_pos)

			local tr = util.TraceLine({
				start = start,
				endpos = endpos
			})

			if (tr.Hit) then
				local col = matstruct[tr.MatType]


				surface.SetDrawColor(col)
				surface.DrawRect(minimap_x + (minimap_w * density_ui) - x * density_ui - density_ui, minimap_y + y * density_ui, density_ui, density_ui)
			end

			y = y + 1
		end

		x = x + 1
	end
end)
