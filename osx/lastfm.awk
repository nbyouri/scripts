BEGIN {
	FS="[><]"
	URL="http://ws.audioscrobbler.com/1.0/user/Beastie_/recenttracks.rss?limit=1"
	subs["–"] = "-"
	subs["amp;"] = ""
	cmd = sprintf("%s %s 2>/dev/null", "curl", URL);

	while(cmd | getline) {
		if (/^ *<title>/) {
			for (s in subs) {
				gsub(s, subs[s], $3);
			}
			print $3
		}
	}
}
