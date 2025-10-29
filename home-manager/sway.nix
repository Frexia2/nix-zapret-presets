{ config, pkgs, ... }:

let
	swaybarscript = pkgs.writeShellScriptBin "sway-bar" ''
#!/bin/sh
status_bar() {
    date=$(date +'%d-%m-%Y %X')
    vol=$(pamixer --get-volume)
    battery_status=$(cat /sys/class/power_supply/BAT0/uevent | grep "POWER_SUPPLY_CAPACITY=" | cut -d= -f2) 
#   linux_version=$(uname -r | cut -d '-' -f1)
    current_layout=$(swaymsg -t get_inputs | jq -r '.[] | select(.type=="keyboard") | .xkb_active_layout_name' | head -n1)
    cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    ram=$(free | awk 'NR==2{printf "%.0f", $3/$2 * 100}')

# i have lost it
    if command -v brightnessctl >/dev/null 2>&1; then
        brightness=$(brightnessctl get)
        max_brightness=$(brightnessctl max)
        brightness_percent=$((brightness * 100 / max_brightness))
        brightness_display="br:$brightness_percent%"
    elif [ -d /sys/class/backlight ]; then
        card=$(ls /sys/class/backlight/ | head -n1)
        if [ -n "$card" ]; then
            current_brightness=$(cat /sys/class/backlight/$card/brightness 2>/dev/null)
            max_brightness=$(cat /sys/class/backlight/$card/max_brightness 2>/dev/null)
            if [ -n "$current_brightness" ] && [ -n "$max_brightness" ]; then
                brightness_percent=$((current_brightness * 100 / max_brightness))
                brightness_display="br:$brightness_percent%"
            else
                brightness_display="br:"
            fi
        else
            brightness_display="br:/A"
        fi
    else
        brightness_display="br:/A"
    fi

    echo "|vol:$vol%|bat:$battery_status%|cpu:''${cpu}%|ram:''${ram}%|$brightness_display|$date|$current_layout"
}

audio_status() {
    if pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes"; then
        echo "muted"
    else
        echo "unmuted"
    fi
}

network_status() {
    if ping -c 1 -W 2 8.8.8.8 &> /dev/null; then
        ip=$(ip route get 1 2>/dev/null | awk '{print $7; exit}' | grep -v 127.0.0.1)
        if [ -n "$ip" ]; then
            echo "$ip|"
        fi
    else
        echo "offline|"
    fi
}

media_status() {
    if playerctl status >/dev/null 2>&1; then
        status=$(playerctl status)
        artist=$(playerctl metadata artist 2>/dev/null || echo "")
        title=$(playerctl metadata title 2>/dev/null)

        if [ -n "$artist" ]; then
            echo "''${artist:0:15} - ''${title:0:20}|"
        else
            echo "''${title:0:35}|"
        fi
    else
        echo ""
    fi
}

vpn_status() {
    if ip addr | grep -q "tun0"; then
        echo "ovpn|"
    elif ip addr | grep -q "wg0"; then
        echo "wg|"
    else
        echo ""
    fi
}

while true; do
	echo "$(media_status)$(vpn_status)$(network_status)$(audio_status)$(status_bar)"
    sleep 1
done
'';
in {
home.packages = [ swaybarscript ];
wayland.windowManager = {
	sway = {
		enable = true;
		wrapperFeatures.gtk = true;
		
		config = null;

		extraConfig = ''
set $mod Mod4
set $alt Mod1

set $left j
set $down k
set $up i
set $right l

set $left_ru Cyrillic_o
set $down_ru Cyrillic_el
set $up_ru Cyrillic_sha
set $right_ru Cyrillic_de

set $term foot
set $menu wmenu-run

font monospace 10

output * bg ${./wallpaper.jpg} fill

   input type:touchpad {
 	 events disabled
   }

   input type:keyboard {
       xkb_layout us,ru
       xkb_options grp:alt_shift_toggle
   }

gaps inner 4
gaps outer 2

default_border pixel 3
default_floating_border pixel 3

client.focused 		#4d0099 #141216 #ffe6f2 #4d0099 #4d0099
client.focused_inactive #330066 #141216 #ffe6f2 #330066 #330066
client.unfocused	#330066 #141216 #ffe6f2 #330066 #330066
client.urgent		#ecb3ff #141216 #ffe6f2 #ecb3ff #ecb3ff
client.placeholder	#330066 #141216 #ffe6f2 #330066 #330066

seat seat0 xcursor_theme Bibata-Modern-Classic 16

    bindcode Mod1+24 exec $term # q
    bindcode $mod+54 kill # c
    bindcode $mod+40 exec $menu # d

    floating_modifier $mod normal

    bindsym $mod+Shift+r reload
    bindsym $mod+Shift+Cyrillic_ka reload

    bindcode $mod+Shift+26 exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit' # e

    bindsym $mod+$left focus left
    bindsym $mod+$down focus down
    bindsym $mod+$up focus up
    bindsym $mod+$right focus right

    bindsym $mod+$left_ru focus left
    bindsym $mod+$down_ru focus down
    bindsym $mod+$up_ru focus up
    bindsym $mod+$right_ru focus right

    bindsym $mod+Left focus left
    bindsym $mod+Down focus down
    bindsym $mod+Up focus up
    bindsym $mod+Right focus right

    bindsym $mod+Shift+$left move left
    bindsym $mod+Shift+$down move down
    bindsym $mod+Shift+$up move up
    bindsym $mod+Shift+$right move right

    bindsym $mod+Shift+$left_ru move left
    bindsym $mod+Shift+$down_ru move down
    bindsym $mod+Shift+$up_ru move up
    bindsym $mod+Shift+$right_ru move right

    bindsym $mod+Shift+Left move left
    bindsym $mod+Shift+Down move down
    bindsym $mod+Shift+Up move up
    bindsym $mod+Shift+Right move right

    bindsym $mod+1 workspace number 1
    bindsym $mod+2 workspace number 2
    bindsym $mod+3 workspace number 3
    bindsym $mod+4 workspace number 4
    bindsym $mod+5 workspace number 5
    bindsym $mod+6 workspace number 6
    bindsym $mod+7 workspace number 7
    bindsym $mod+8 workspace number 8
    bindsym $mod+9 workspace number 9
    bindsym $mod+0 workspace number 10
    
    bindsym $mod+Shift+1 move container to workspace number 1
    bindsym $mod+Shift+2 move container to workspace number 2
    bindsym $mod+Shift+3 move container to workspace number 3
    bindsym $mod+Shift+4 move container to workspace number 4
    bindsym $mod+Shift+5 move container to workspace number 5
    bindsym $mod+Shift+6 move container to workspace number 6
    bindsym $mod+Shift+7 move container to workspace number 7
    bindsym $mod+Shift+8 move container to workspace number 8
    bindsym $mod+Shift+9 move container to workspace number 9
    bindsym $mod+Shift+0 move container to workspace number 10


    bindsym $mod+b splith
    bindsym $mod+Cyrillic_i splith

    bindsym $mod+v splitv
    bindsym $mod+Cyrillic_em splitv

    bindcode $mod+39 layout stacking # s
    bindcode $mod+25 layout tabbed # w
    bindcode $mod+26 layout toggle split # e

    bindsym --to-code $mod+f fullscreen

    bindsym --to-code $alt+f floating toggle

    bindsym $mod+space focus mode_toggle

    bindsym $mod+a focus parent
    bindsym $mod+Cyrillic_ef focus parent

    bindsym $mod+Shift+minus move scratchpad

    bindsym $mod+minus scratchpad show

mode "resize" {

    bindsym $left resize shrink width 10px
    bindsym $down resize shrink height 10px
    bindsym $up resize grow height 10px
    bindsym $right resize grow width 10px

    bindsym $left_ru resize shrink width 10px
    bindsym $down_ru resize shrink height 10px
    bindsym $up_ru resize grow height 10px
    bindsym $right_ru resize grow width 10px

    bindsym Left resize shrink width 10px
    bindsym Down resize shrink height 10px
    bindsym Up resize grow height 10px
    bindsym Right resize grow width 10px

    bindsym Return mode "default"
    bindsym Escape mode "default"
}
bindsym $mod+r mode "resize"
bindsym $mod+Cyrillic_ka mode "resize"

    bindsym --locked XF86AudioMute exec pactl set-sink-mute \@DEFAULT_SINK@ toggle
    bindsym --locked XF86AudioLowerVolume exec pactl set-sink-volume \@DEFAULT_SINK@ -5%
    bindsym --locked XF86AudioRaiseVolume exec pactl set-sink-volume \@DEFAULT_SINK@ +5%
    bindsym --locked XF86AudioMicMute exec pactl set-source-mute \@DEFAULT_SOURCE@ toggle

    bindsym --locked XF86MonBrightnessDown exec brightnessctl set 5%-
    bindsym --locked XF86MonBrightnessUp exec brightnessctl set 5%+
    bindsym Print exec grim - | wl-copy
    bindsym Shift+Print exec grim -g "$(slurp)" - | wl-copy

bar {
    position bottom

  status_command ${swaybarscript}/bin/sway-bar
    colors {
        statusline #ffffff
        background #323232
        inactive_workspace #323232 #323232 #5c5c5c
	focused_workspace #323232 #7733ff #ffe6f2
    }
}

include /etc/sway/config.d/*
				
			'';
		};
	};
}
