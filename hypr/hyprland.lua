-- Hyprland configuration for 0.56 and newer.
-- https://wiki.hypr.land/Configuring/Start/

local colors = require("mocha")

local function rgba(hex, alpha)
	return "rgba(" .. hex .. (alpha or "") .. ")"
end

local terminal = "kitty"
local fileManager = "nautilus"
local menu =
	[[rofi -show-icons -icon-theme "Papirus" -theme "catppuccin-mocha" -show combi -modes combi -combi-modes "window,drun"]]
local mainMod = "SUPER"

-- Monitors
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("fcitx5 -d")
	hl.exec_cmd("mako")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd([[sh -c "sleep 3 && keepassxc"]])
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)

-- Environment
hl.env("GDK_SCALE", "2")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

-- Core options
hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
	ecosystem = {
		no_update_news = true,
	},
	general = {
		gaps_in = 4,
		gaps_out = 8,
		border_size = 2,
		col = {
			active_border = {
				colors = { rgba(colors.mauve, "ee"), rgba(colors.red, "ee") },
				angle = 45,
			},
			inactive_border = rgba(colors.blue, "aa"),
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 0,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		dim_inactive = true,
		dim_strength = 0.1,
		dim_special = 0.4,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
		blur = {
			enabled = false,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
	animations = {
		enabled = false,
	},
	dwindle = {
		preserve_split = true,
	},
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
		disable_splash_rendering = true,
	},
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:win_space_toggle",
		kb_rules = "",
		follow_mouse = 1,
		accel_profile = "flat",
		sensitivity = 0.2,
		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
		},
	},
	group = {
		groupbar = {
			enabled = false,
		},
		col = {
			border_active = {
				colors = { rgba(colors.teal, "ee"), rgba(colors.green, "ee") },
				angle = 45,
			},
			border_inactive = rgba(colors.yellow, "88"),
		},
	},
})

-- Curves and animations
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "easeInOutCubic", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.7, bezier = "easeInOutCubic" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.7, bezier = "easeInOutCubic" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Three-finger horizontal workspace switching
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Applications and session controls
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + DELETE", hl.dsp.exit())
-- hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + CTRL + P", hl.dsp.window.pin())
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + X", function()
	hl.config({ animations = { enabled = false } })
end)
hl.bind(mainMod .. " + SHIFT + X", function()
	hl.config({ animations = { enabled = true } })
end)
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Grouped windows
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + bracketleft", hl.dsp.group.prev(), { repeating = true })
hl.bind(mainMod .. " + bracketright", hl.dsp.group.next(), { repeating = true })

-- Brightness and display power
hl.bind(mainMod .. " + CTRL + bracketleft", hl.dsp.exec_cmd("brightnessctl set 2500-"), { repeating = true })
hl.bind(mainMod .. " + CTRL + bracketright", hl.dsp.exec_cmd("brightnessctl set +2500"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 2500-"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +2500"), { repeating = true })
hl.bind(mainMod .. " + CTRL + O", hl.dsp.dpms({ action = "toggle" }))

-- Audio and media
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ repeating = true, locked = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

-- Screenshots
hl.bind(
	"CTRL + Print",
	hl.dsp.exec_cmd([[grim $(xdg-user-dir PICTURES)/Screenshots/$(date +'%F_%H-%M-%S.png')]]),
	{ locked = true }
)
hl.bind(
	"Print",
	hl.dsp.exec_cmd([[grim -g "$(slurp)" $(xdg-user-dir PICTURES)/Screenshots/$(date +'%F_%H-%M-%S.png')]]),
	{ locked = true }
)
hl.bind("CTRL + ALT + Print", hl.dsp.exec_cmd("grim - | wl-copy"), { locked = true })
hl.bind("ALT + Print", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]), { locked = true })

-- Focus movement
local directions = {
	left = "l",
	right = "r",
	up = "u",
	down = "d",
	H = "l",
	L = "r",
	K = "u",
	J = "d",
}

for key, direction in pairs(directions) do
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = direction }))
	hl.bind(
		mainMod .. " + SHIFT + " .. key,
		hl.dsp.window.move({
			direction = direction,
			group_aware = true,
		})
	)
end

-- Window resizing
local resizeDirections = {
	H = { x = -20, y = 0 },
	L = { x = 20, y = 0 },
	K = { x = 0, y = -20 },
	J = { x = 0, y = 20 },
}

for key, delta in pairs(resizeDirections) do
	hl.bind(
		mainMod .. " + ALT + " .. key,
		hl.dsp.window.resize({
			x = delta.x,
			y = delta.y,
			relative = true,
		}),
		{ repeating = true }
	)
end

-- Workspaces 1-10
for workspace = 1, 10 do
	local key = workspace % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

for key, workspace in pairs({
	mouse_down = "e+1",
	mouse_up = "e-1",
	Page_Up = "e+1",
	Page_Down = "e-1",
}) do
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
end
hl.bind(mainMod .. " + SHIFT + bracketleft", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.focus({ workspace = "e+1" }))

-- Mouse window movement and resizing
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Window rules
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "float-windscribe",
	match = {
		class = "^(Windscribe)$",
		title = "^(Windscribe)$",
	},
	float = true,
})
