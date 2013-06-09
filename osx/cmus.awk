#!/usr/bin/awk -f

function CmusInfo() {
	cmd = "cmus-remote -Q"
	while(cmd | getline) {
		if(/tag artist/) {
			for(i=3; i<=NF; i++) {
				artist=artist $i" "
			}
		}
		if(/tag title/) {
			t = NF;
			for(i=3; i<=NF; i++) {
				title=title $i" "
			}
		}
	}
	close(cmd)
	print artist "- " title
}

BEGIN {
	CmusInfo();
}
