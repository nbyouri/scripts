#!/usr/bin/awk -f
#nawk aka one-true-awk aka BWK awk used.
#use this with lemonboy bar.

function ActiveWindow() {
    while("xprop -root _NET_ACTIVE_WINDOW"|getline) {
        if(/0x/) {
            sprintf("xprop WM_NAME -id %s", $5)|getline;
            gsub("\"", "",$3);
        }
        printf "\\b0\\u0 \\b2 "
        for(i = 3; i<=NF;i++) 
            printf  $i" "
    }
}

function BattInfo() {
    while("pmset -g batt"|getline) {
        if (/%/) {
            t = $2
            sub(/;/,"", t); 
            sub(/%/,"", t);
            printf "\\u0\\b0 \\u2\\b2 "t"\%% "
        }
    }
}

function CmusInfo() {
    while("cmus-remote -Q"|getline) {
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
    printf "\\b0\\u0  \\b2\\u2 "
    printf artist "- " title
}

function CpuTemp() {
    while ("smc -f"|getline) {
        if(/Temp         =/) {
            t = $3
        }
    }
    printf("\\b0\\u0  \\u2\\b2 %.0f\° ", t)
}

function CurrentWorkspace() {
    while("xprop -root _NET_CURRENT_DESKTOP"|getline) {
        t = $3+1
    }
    return t
}

function DiskInfo() {
    while("df"|getline) {
        if(/disk0s2/) {
            t = $5;
            sub(/%/,"", t);
            printf "\\u0\\b0  \\u2\\b2 "t"\%% "
        }
    }
}

#Needs to be fixed
function FanSpeed() {
    while("smc -f"|getline) {
        if(/Actual/) {
            printf "\\u0\\b0  \\u2\\b2 "$4" rpm "
        }
    }
}

function LastFm() {
    FS="[><]"
    URL="http://ws.audioscrobbler.com/1.0/user/Beastie_/recenttracks.rss?limit=1"
    subs["–"] = "-"
    subs["amp;"] = ""
    cmd = sprintf("%s %s 2>/dev/null", "curl", URL);
    while(cmd|getline) {
        if (/^ *<title>/) {
            for (s in subs) {
                gsub(s, subs[s], $3);
            }
            printf "\\b0\\u0  \\b2\\u2 "
            printf $3
        }
    }
}

function MailCount() {
    URL="https://youri.mout:************@mail.google.com/mail/feed/atom"
    subs["<[^>]+>"] = ""
    cmd = sprintf("%s %s 2>/dev/null", "curl", URL);
    while(cmd|getline) {
        if(/fullcount/){
            for (s in subs) {
                gsub(s, subs[s]);
            }
            printf "\\u0\\b0  \\b2\\u2 "$0
        }
    }
}

function MemUsage() {
    while("vm_stat"|getline) {
        if(/Pages active/) {
            t = $3
            printf(" \\b0\\u0  \\b2\\u2 %.0fm ", t*0.004);
        }
    }
}

function NcmpcppPlaying() {
    while("ncmpcpp --now-playing"|getline) {
        printf "\\b0\\u0  \\b2\\u2 "
        for(i = 2; i<=NF; i++) {
            printf $i" "
        }
    }
}

#Needs to be fixed.
function NetUsage() {
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
    printf "\\b0\\u0  \\b2\\u2 "
    printf("%.2f  ", inp/1024)
    printf("%.2f\n", out/1024)
} 

function TimeDate() {
    while("date \"+%d/%H:%M\""|getline) {
        printf "\\b0\\u0  \\b2\\u2 "$0" " 
    }
}

function TotalWorkspaces() {
    while("xprop -root _NET_NUMBER_OF_DESKTOPS"|getline) {
        t = $3+1
    }
    return t
}
     
# This needs to be fixed.
function UhRss() {
    FS="[\\[\\]]"
    URL="http://forums.unixhub.net/syndication.php?limit=1"
    cmd = sprintf("%s %s 2>/dev/null", "curl", URL);
    while(cmd|getline) {
        if (/<title><!\[CDATA\[.*]\]/) {
            t = $3
        }
    }
    printf "\\b0\\u0  \\b2\\u2"
    printf t
}

function Volume() { 
    while("ioreg -c IOAudioLevelControl"|getline) {
        if(/IOAudioControlValue/) {
            t = $8
        }
    }
    printf("\\b0\\u0 \\b2\\u2 %.0f%% ", t/64*100);
}

function WorkspaceViewer() {
    CWI[1]=""
    CWI[2]=""
    CWI[3]=""
    CWI[4]=""
    CWI[5]=""
    #TWS = TotalWorkspaces() 
    # You might want to enter this as a constant.
    TWS = 5
    CW  = CurrentWorkspace()
    for(i = 1; i<=TWS; i++) {
        if(i == CW) {
            buffer=buffer"\\u0\\b0 "CWI[i]" \\u2\\b2"
        } else {
            buffer=buffer " "CWI[i]" "
        }
    }
    printf buffer
}

function LeftStatus() {
    printf "\\l"
    print TimeDate()Volume()NcmpcppPlaying()ActiveWindow()
}

function CenterStatus() {
    printf "\\c"
    printf WorkspaceViewer()
}

function RightStatus() {
    printf "\\r"
    printf CpuTemp()BattInfo()DiskInfo()MemUsage()
}

BEGIN {
    LeftStatus()
    CenterStatus()
    RightStatus()
}
