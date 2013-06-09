#!/bin/sh
# -- Beastie, 09/06/2012

SEP=`echo "//"`
SPA=`echo -n "\f0\u0\b0Y"`

cpuinfo() {

CPUTEMP=`sysctl -n dev.cpu.0.temperature`
CPU=$(top -b -o res | awk 'NR>8 { gsub(/%/,"",$0); CPU+=$11; } END { split(CPU,cpu,"."); print cpu[1] "%"; }')

echo -n "\l$SPA\f4$CPUTEMP \f2$SEP \f4$CPU"

}

printdate() {

HMS=`date | awk '{print $4}'`

echo -n "\c\f6$HMS"

}

ramfsusage() {

RAM=$(top -d 1 0 | awk 'NR==4 {print $2}')
DISK=$(zpool list | awk 'NR==2 {print $5}')

echo -n "\r\f5$DISK\f2\ $SEP \f5$RAM$SPA"

}

batterystatus() {

# apm -l ?
TIMEBATT=`sysctl -n hw.acpi.battery.time`
# use sysctl -n hw.acpi.battery.life for %

echo -n "\f2$SEP \f5$TIMEBATT Min $SPA"

}
# For volume, use awk magic on mixer.
# Netwerk thing?
# uptime?
# fan speed
# mail
# brightness
# cmus song

while true; do
		echo "$(cpuinfo)$(printdate)$(ramfsusage)$(batterystatus)" 
sleep 1;
done

