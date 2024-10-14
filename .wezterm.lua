local wezterm = require("wezterm")

return {
	font = wezterm.font("JetBrainsMono Nerd Font", { weight = "SemiBold", style = "Normal" }),
	font_size = 15,
	color_scheme = "iTerm2 Smoooooth",
	dpi = 200.0,
	font_hinting = "Full",
	bold_brightens_ansi_colors = true,
	scrollback_lines = 10000,
}
