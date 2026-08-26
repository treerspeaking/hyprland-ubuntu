-- This one is used for selecting the themes of the back ground in themes/

Name = "BackgroundThemeSelector"
NamePretty = "Background Theme Selector"
Cache = false
HideFromProviderlist = true
SearchName = true

function GetEntries()
	local entries = {}
	local home_dir = os.getenv("HOME")
	local find_dir = home_dir .. "/.local/share/hyprland-ubuntu/themes/*/"
	local handle = io.popen('printf "%s\n" ' .. find_dir, "r")
	if not handle then
		return
	end

	for entry in handle:lines() do
		local theme_name = entry:match("([^/]+)/$")
		local display_name = theme_name:gsub("%-", " ")
		display_name = display_name:gsub("(%a)([%w_']*)", function(first, rest)
			return first:upper() .. rest:lower()
		end)

		table.insert(entries, {
			Text = display_name,
			Value = theme_name,
			SubMenu = "omarchyBackgroundSelector",
		})
	end

	return entries
end
