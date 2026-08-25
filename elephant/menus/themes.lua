--
-- Dynamic Omarchy Theme Menu for Elephant/Walker
--
Name = "omarchythemes"
NamePretty = "Omarchy Themes"
HideFromProviderlist = true

-- Check if file exists using Lua (no subprocess)
local function file_exists(path)
	local f = io.open(path, "r")
	if f then
		f:close()
		return true
	end
	return false
end

-- Get first matching file from directory using ls (single call for fallback)
local function first_image_in_dir(dir)
	local handle = io.popen("ls -1 '" .. dir .. "' 2>/dev/null | head -n 1")
	if handle then
		local file = handle:read("*l")
		handle:close()
		if file and file ~= "" then
			return dir .. "/" .. file
		end
	end
	return nil
end

-- Find preview.png, preview.jpg, or first backgrounds/ image in a theme dir
local function find_preview_path(dir)
	local png = dir .. "preview.png"
	local jpg = dir .. "preview.jpg"
	if file_exists(png) then
		return png
	end
	if file_exists(jpg) then
		return jpg
	end
	return first_image_in_dir(dir .. "backgrounds")
end

-- The main function elephant will call
function GetEntries()
	local entries = {}
	local user_theme_dir = os.getenv("HOME") .. "/.local/share/hyprland-ubuntu/themes"
	local find_dir = user_theme_dir .. "/*/"
	-- get all the directory in themes
	local handle = io.popen('printf "%s\n" ' .. find_dir, "r")
	if not handle then
		return
	end

	for entry in handle:lines() do
		local display_name = entry:match("([^/]+)/$"):gsub("%-", " ")
		local preview_path = find_preview_path(entry)
		display_name = display_name:gsub("(%a)([%w_']*)", function(first, rest)
			return first:upper() .. rest:lower()
		end)

		table.insert(entries, {
			Text = display_name,
			Preview = preview_path,
			PreviewType = "file",
			Actions = {
				activate = "~/.local/share/hyprland-ubuntu/shell/set-theme.sh " .. " ",
			},
		})
	end

	handle:close()

	return entries
end
-- Check if file exists using Lua (no subprocess)
