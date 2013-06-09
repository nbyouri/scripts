#!/usr/bin/awk -f

BEGIN {
	cmd = "df"
	while(cmd|getline) {
		if(/disk0s2/) {
			print $5
		}
	}
}
