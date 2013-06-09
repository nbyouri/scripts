BEGIN {
	URL="https://youri.mout:******************8@mail.google.com/mail/feed/atom"
	subs["<[^>]+>"] = ""
	cmd = sprintf("%s %s 2>/dev/null", "curl", URL);

	while(cmd | getline) {
		if(/fullcount/){
				for (s in subs) {
						gsub(s, subs[s]);
				}
				print 
		}
	}
}
