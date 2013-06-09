BEGIN {
	cmd = "pmset -g batt"
	while(cmd | getline) {
		if (/%/) {
			t = $2
			sub(/;/,"", t);
		}
	}
	print t
}
