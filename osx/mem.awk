BEGIN {
	cmd= "vm_stat"
	while(cmd | getline) {
		if(/Pages active/) {
			t = $3
			printf("%.0f", t*0.004);
		}
	}
}
