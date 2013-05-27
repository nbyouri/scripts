BEGIN {
		URL="https://youri.mout:**************@mail.google.com/mail/feed/atom"
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
