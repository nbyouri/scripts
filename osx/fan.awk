BEGIN {
	cmd = "smc -f"
	while(cmd|getline) {
		if(/Actual/) {
			print $4" rpm"
		}
	}
}
