# This requires TemperatureMonitor.app.
BEGIN {
		cmd = "/Applications/TemperatureMonitor.app/Contents/MacOS/tempmonitor -c"

		while (cmd | getline) {
				print $1"°"
		}
}

