{ config, pkgs, ...}:
{

services.mako = {
	enable = true;
	settings = {
		backgroundColor = "#141216";
		textColor = "#ffe6f2";
		width = "300";
		height = "70";
		borderSize = "1";
		borderColor = "#ffe6f2";
		icons = "0";
		defaultTimeout = "5000";
		layer = "top";
		anchor = "bottom-right";
	};
	extraConfig = ''
	[urgency=low]
 	background-color=#141216
	border-color=#39004d
	text-color=#ffe6f2
	default-timeout=5000

	[urgency=normal]
	background-color=#141216
	border-color=#ffe6f2
	text-color=#ffe6f2
	default-timeout=5000

	[urgency=high]
	background-color=#ff3300
	border-color=#ffe6f2
	text-color=#000000
	default-timeout=0
'';
};

}
