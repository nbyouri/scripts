BEGIN {
		cmd = "smc -f"
		while (cmd | getline) {
				if(/Temp         =/) {
						printf("%.0f°\n", $3)
				}
		}
}

