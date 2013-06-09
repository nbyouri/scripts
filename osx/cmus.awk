#!/usr/bin/awk -f

function CmusInfo() {
	cmd = "cmus-remote -Q"
	while(cmd | getline) {
		if(/tag artist/) {
			t = NF+1;
			for(i=3; i<t; i++) {
				artist=artist $i " "
			}
		}
		if(/tag title/) {
			t = NF+1;
			for(i=3; i<t; i++) {
				title=title $i " "
			}
		}
	}
	close(cmd)
	print artist "- " title
}

BEGIN {
	CmusInfo();
}
