-- The naming is attrocious sorry
-- This will be only called for the first time of themes
-- after which it will be back to the normal background_them_selector

Name = "BackgroundSelectorForTheme"
FixedOrder = true
Parent = "omarchythemes"
NamePretty = "Background Selector For Theme"
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

	local current_background_file =
		io.open(home_dir .. "/.local/share/omarchy-ubuntu/current-omarchy-ubuntu/theme/current-background.name")
	local current_background_dir = current_background_file and current_background_file:read("*l") or nil
	-- add back the home_dir cause background.name does not have absolute directory
	current_background_dir = home_dir .. current_background_dir
	local current_background = current_background_dir:match("([^/]+)$")
	if current_background_file then
		current_background_file:close()
	end

	table.insert(entries, {
		Text = FormatName(current_background),
		value = current_background_dir,
		Actions = {
			activate = home_dir .. "/.local/share/omarchy-ubuntu/shell/set-background.sh " .. ShellEscape(
				current_background_dir
			),
		},
		Preview = current_background_dir,
		PreviewType = "file",
	})

	local theme_name = lastMenuValue("omarchythemes")
	if theme_name ~= "" then
		-- call the deffered execution from themes.lua
		os.execute(
			home_dir .. "/.local/share/omarchy-ubuntu/shell/set-theme-background.sh " .. ShellEscape(theme_name)
		)
	end

	-- Directories to search
	local dirs = {
		home_dir .. "/.local/share/omarchy-ubuntu/themes/" .. theme_name .. "/backgrounds",
	}

	-- Track added files to avoid duplicates
	local seen = { [current_background] = true }

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
