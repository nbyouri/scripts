BEGIN {
	cmd = "xprop -root _NET_ACTIVE_WINDOW"
	while(cmd|getline) {
		if(/0x/) {
			sprintf("xprop WM_NAME -id %s", $5) | getline;
			gsub("\"", "",$3);
		}
		print $3;
	}
	#system("sleep 1");
}
