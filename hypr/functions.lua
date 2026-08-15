local border_hidden = false
local border_size_before = nil

local function toggle_border()
	if border_hidden then
		hl.config({ general = { border_size = border_size_before } })
	else
		border_size_before = hl.get_config("general:border_size")
		hl.config({ general = { border_size = 0 } })
	end
	border_hidden = not border_hidden
end

return {
	toggle_border = toggle_border,
}
