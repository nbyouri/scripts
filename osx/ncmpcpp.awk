#!/usr/bin/awk -f
BEGIN {
	cmd = "ncmpcpp --now-playing"
	while(cmd|getline) {
		t = NF+1
		for(i = 2; i<t; i++) {
			printf $i" "
		}
	}
	printf "\n"
}
