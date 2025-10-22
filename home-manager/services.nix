{ config, pkgs, self, inputs, ... }:

{
services = {
	udiskie = {
		enable = true;
		automount = true;
		notify = true;
		tray = "always";
    		settings = {
        		program_options = {
				file_manager = "${pkgs.nemo}/bin/nemo";
			};
 		};
	};
};
home.stateVersion = "25.05";
home.packages = with pkgs; [
];
}
