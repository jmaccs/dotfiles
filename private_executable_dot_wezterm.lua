local w = require("wezterm")
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end
local home = os.getenv("HOME")
local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = w.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end
w.add_to_config_reload_watch_list("/Users/joemac/.cache/wal/wezterm.toml")
return {

	--	color_scheme_dirs = { "/Users/joemac/.cache/wal" },
	color_scheme = "Catppuccin Macchiato (Gogh)",
	enable_kitty_graphics = true,

	enable_csi_u_key_encoding = true,
	-- colors = {
	--   background = "#0c0e14",
	-- },
	window_decorations = "RESIZE",
	macos_window_background_blur = 10,
	window_background_opacity = 0.95,
	send_composed_key_when_left_alt_is_pressed = true,
	font = w.font("Lilex Nerd Font"),
	font_size = 13.0,
	-- dpi = 192.0,
	hide_tab_bar_if_only_one_tab = true,
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		-- pomodoro
		{
			key = "p",
			mods = "OPT",
			action = w.action_callback(function(window, pane)
				w.run_child_process({

					"pomodoro",
				})
			end),
		},
		-- move between split panes
		split_nav("move", "h"),
		split_nav("move", "j"),
		split_nav("move", "k"),
		split_nav("move", "l"),
		-- resize panes
		split_nav("resize", "h"),
		split_nav("resize", "j"),
		split_nav("resize", "k"),
		split_nav("resize", "l"),

		{
			key = "d",
			mods = "SUPER",
			action = w.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "d",
			mods = "SUPER|SHIFT",
			action = w.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "w",
			mods = "CMD",
			action = w.action.CloseCurrentPane({ confirm = false }),
		},
		{
			mods = "LEADER",
			key = "-",
			action = w.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			mods = "LEADER",
			key = "=",
			action = w.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
	},
}
