BEGIN {
	FS="[\\[\\]]"
	URL="http://forums.unixhub.net/syndication.php?limit=1"
	cmd = sprintf("%s %s 2>/dev/null", "curl", URL);

	while(cmd | getline) {
		if (/<title><!\[CDATA\[.*]\]/) {
			t = $3
		}
	}
	print t
}