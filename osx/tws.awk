# Displays the total number of workspaces.

BEGIN {
	cmd = "xprop -root _NET_NUMBER_OF_DESKTOPS"

	while(cmd | getline) {
					t = $3
	}
	print t
}

     
