BEGIN {
	cmd = "netstat -ib -I en0"
	while(cmd|getline) {
			inp1 = $7
       out1 = $10
	}
	close(cmd)
	system("sleep 1");
	while(cmd|getline) {
       inp2 = $7
       out2 = $10
	}
	inp = inp2 - inp1
	out = out2 - out1

	printf("%.2f  ", inp/1024)
	printf("%.2f\n", out/1024)
}
