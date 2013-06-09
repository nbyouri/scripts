#!/usr/bin/awk -f
BEGIN {
	cmd = "ncmpcpp --now-playing"
	while(cmd|getline) {
		for(i = 2; i<=NF; i++) {
			printf $i" "
		}
	}
	printf "\n"
}
