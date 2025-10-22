{ config, pkgs, ...}:
{

services.mako = {
	enable = true;

	extraConfig = ''
	background-color=#141216
	text-color=#ffe6f2
	width=300
	height=70
	border-size=1
	border-color=#ffe6f2
	icons=0
	default-timeout=5000
	layer=top
	anchor=bottom-right
		
	[urgency=low]
 	background-color=#141216
	border-color=#39004d
	text-color=#ffe6f2
	icons=0
	default-timeout=5000

	[urgency=normal]
	background-color=#141216
	border-color=#ffe6f2
	text-color=#ffe6f2
	icons=0
	default-timeout=5000

	[urgency=high]
	background-color=#ff3300
	border-color=#ffe6f2
	text-color=#000000
	icons=0
	default-timeout=0
'';
};

}
