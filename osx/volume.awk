BEGIN { 
	cmd = "ioreg -c IOAudioLevelControl"
	while(cmd | getline) {
		if(/IOAudioControlValue/) {
			t = $8
 		}
	}
        printf("%.0f%%", t/64*100);
}