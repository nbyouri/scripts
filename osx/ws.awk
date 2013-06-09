# Displays the current workspace.

BEGIN {
	cmd = "xprop -root _NET_CURRENT_DESKTOP"

	while(cmd | getline) {
		t = $3+1
	}
	print t
}

     
