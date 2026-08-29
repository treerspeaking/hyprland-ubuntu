-- Modified from https://github.com/basecamp/omarchy/blob/v3.8.4/default/elephant/omarchy_background_selector.lua
-- This one is used to selecting the background after a theme has been select by BackgroundThemeSelector

Name = "omarchyBackgroundSelector"
FixedOrder = true
NamePretty = "Omarchy Background Selector"
Parent = "BackgroundThemeSelector"
Cache = false
HideFromProviderlist = true
SearchName = true

local function ShellEscape(s)
	return "'" .. s:gsub("'", "'\\''") .. "'"
end

function FormatName(filename)
	-- Remove leading number and dash
	local name = filename:gsub("^%d+", ""):gsub("^%-", "")
	-- Remove extension
	name = name:gsub("%.[^%.]+$", "")
	-- Replace dashes with spaces
	name = name:gsub("-", " ")
	-- Capitalize each word
	name = name:gsub("%S+", function(word)
		return word:sub(1, 1):upper() .. word:sub(2):lower()
	end)
	return name
end

function GetEntries()
	local entries = {}
	local home_dir = os.getenv("HOME")

	local theme_name = lastMenuValue("BackgroundThemeSelector")

	-- Directories to search
	local dirs = {
		home_dir .. "/.local/share/omarchy-ubuntu/themes/" .. theme_name .. "/backgrounds",
	}

	-- Track added files to avoid duplicates
	local seen = {}

	for _, wallpaper_dir in ipairs(dirs) do
		local handle = io.popen(
			"find -L "
				.. ShellEscape(wallpaper_dir)
				.. " -maxdepth 1 -type f \\( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.gif' -o -name '*.bmp' -o -name '*.webp' \\) 2>/dev/null | sort"
		)
		if handle then
			for background in handle:lines() do
				local filename = background:match("([^/]+)$")
				if filename and not seen[filename] then
					seen[filename] = true
					table.insert(entries, {
						Text = FormatName(filename),
						Value = background,
						Actions = {
							activate = home_dir
								.. "/.local/share/omarchy-ubuntu/shell/set-background.sh "
								.. ShellEscape(background),
						},
						Preview = background,
						PreviewType = "file",
					})
				end
			end
			handle:close()
		end
	end

	table.insert(entries, { Text = "󰌍  Back", SubMenu = "BackgroundThemeSelector", PreviewType = "text" })

	return entries
end
