#!/bin/bash
# by TExtubation
#

# have script pull its own location and check for csm.conf
# if it does not exist create csm.conf
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
if [ ! -f "$SCRIPT_DIR/csm.conf" ]; then
  touch $SCRIPT_DIR/csm.conf
fi

# pre-load variables from csm.conf
contyloc=`awk 'NR==1' $SCRIPT_DIR/csm.conf`;
ubottle=`awk 'NR==2' $SCRIPT_DIR/csm.conf`;
bottle=`awk 'NR==3' $SCRIPT_DIR/csm.conf`;
prog=`awk 'NR==4' $SCRIPT_DIR/csm.conf`;
sgrf=`awk 'NR==5' $SCRIPT_DIR/csm.conf`;
rgtc=`awk 'NR==6' $SCRIPT_DIR/csm.conf`;
gamescope=`awk 'NR==7' $SCRIPT_DIR/csm.conf`;
gswidth=`awk 'NR==8' $SCRIPT_DIR/csm.conf`;
gsheight=`awk 'NR==9' $SCRIPT_DIR/csm.conf`;
gsrefresh=`awk 'NR==10' $SCRIPT_DIR/csm.conf`;
gsfs=`awk 'NR==11' $SCRIPT_DIR/csm.conf`;
dpms=`awk 'NR==12' $SCRIPT_DIR/csm.conf`;
dssaver=`awk 'NR==13' $SCRIPT_DIR/csm.conf`;
anti=`awk 'NR==14' $SCRIPT_DIR/csm.conf`;
cssc=`awk 'NR==15' $SCRIPT_DIR/csm.conf`;
before=`awk 'NR==16' $SCRIPT_DIR/csm.conf`;
after=`awk 'NR==17' $SCRIPT_DIR/csm.conf`;
mango=`awk 'NR==18' $SCRIPT_DIR/csm.conf`;
csf=`awk 'NR==19' $SCRIPT_DIR/csm.conf`;
save=`awk 'NR==20' $SCRIPT_DIR/csm.conf`;
cdf=`awk 'NR==21' $SCRIPT_DIR/csm.conf`;
gname=`awk 'NR==22' $SCRIPT_DIR/csm.conf`;
gicon=`awk 'NR==23' $SCRIPT_DIR/csm.conf`;

# yad script
yad \
  --title="Custom Conty Script Maker" \
  --scroll \
  --width=500 \
  --height=500 \
  --form \
    --text="\nPaths with spaces MAY NOT WORK properly\nHover over option for more info\n" \
    --separator="," \
    --field="Select Conty File:!Select the file associated with starting conty:SFL" \
	--field="Run a Game thru Bottles:!Turn this on to specify a bottle and program executable to run from that bottle:SW" \
    --field="		Bottle Name:!The name of an already created bottle. Bottle names should not contain spaces. Rename Bottle from within Bottles if it does:" \
    --field="		Program Name:!The name of a program to run from within the bottle named above. Program names should not contain spaces. Rename Program from within Bottles if it does:" \
	--field="Select Linux Game Run File:!Select the file used to start the Linux native game. Nvidia users can even append their prime-run command at the beginning after selecting a file:SFL" \
	--field="		Run Game Thru Conty:!This allows the Linux native game to run thru Conty if desired. If you do not have multi-arch installed and working on your system, Conty can be used to run x86 software on an x64 only system:SW" \
	--field="Use Gamescope:!This allows a Linux native or Bottles run game to use Gamescope:SW" \
    --field="		Screen Width::NUM" \
    --field="		Screen Height::NUM" \
    --field="		Refresh Rate::NUM" \
	--field="		Use Full Screen:!This allows Gamescope to run in flullscreen mode. When not selected Gamescope will run in windowed mode:SW" \
	--field="Disable dpms:!When selected this will turn off Display Power Management Signaling using xset before starting a game, and will turn it back on when exiting the game. This might help if the screen dims on its own or goes to sleep during game play:SW" \
	--field="Disable Mate ScreenSaver:!A Mate specific action that inhibits the screensaver from running while playing a game. It also renables it after the game exits:SW" \
	--field="Disable AntimicroX:!This will stop AntimicroX before starting a game, and starts it once again after the game is exited:SW" \
	--field="Custom Before/After Command:!This allows from custom commands to be run before starting a game, and after a game has exited. One or the other or both can be used:SW" \
	--field="	Command to Run Before Game:!Single or multiple commands may be used before the game runs. Bash formatting must be used. Multiple commands may be strung together using &amp;&amp; between commands:" \
	--field="	Command to Run After Game:!Single or multiple commands may be used after the game exits. Bash formatting must be used. Multiple commands may be strung together using &amp;&amp; between commands:" \
	--field="Use MangoHud:!This allows a Linux native or Bottles run game to use MangoHUD:SW" \
	--field="Create Game Launch Script:!This allows the options above to be saved as a script. If it is not selected then no script will be saved, in case you want to only create a desktop file, or save the settings for later:SW" \
    --field="	Save Script to (must end in .sh):!This is the name and location to save the created script as a .sh file. It can also be used by the Create Desktop File option below to use any game launch script or command you want:SFL" \
	--field="Create Desktop File:!This allows the creation of a .desktop file. By default it places the new .desktop file in ~/.local/share/applications which is used by many Linux menu tools automatically. All created .desktop files should show under the Games section of the menu:SW" \
    --field="		Game Name:!Enter the name of the game you would like to create a .desktop file for:" \
    --field="		Select Game Icon:!Any .jpg .png .svg file should work as an icon for the .desktop file. Many .ico .icn .icon files may not work properly:SFL" --add-preview \
    "$contyloc" \
    "$ubottle" \
    "$bottle" \
    "$prog" \
    "$sgrf" \
    "$rgtc" \
    "$gamescope" \
    "$gswidth" \
    "$gsheight" \
    "$gsrefresh" \
    "$gsfs" \
    "$dpms" \
    "$dssaver" \
    "$anti" \
    "$cssc" \
    "$before" \
    "$after" \
    "$mango" \
    "$csf" \
    "$save" \
    "$cdf" \
    "$gname" \
    "$gicon" | while read line; do
  contyloc=$(echo $line | awk 'BEGIN {FS="," } { print $1 }')
  ubottle=$(echo $line | awk 'BEGIN {FS="," } { print $2 }')
  bottle=$(echo $line | awk 'BEGIN {FS="," } { print $3 }')
  prog=$(echo $line | awk 'BEGIN {FS="," } { print $4 }')
  sgrf=$(echo $line | awk 'BEGIN {FS="," } { print $5 }')
  rgtc=$(echo $line | awk 'BEGIN {FS="," } { print $6 }')
  gamescope=$(echo $line | awk 'BEGIN {FS="," } { print $7 }')
  gswidth=$(echo $line | awk 'BEGIN {FS="," } { print $8 }')
  gsheight=$(echo $line | awk 'BEGIN {FS="," } { print $9 }')
  gsrefresh=$(echo $line | awk 'BEGIN {FS="," } { print $10 }')
  gsfs=$(echo $line | awk 'BEGIN {FS="," } { print $11 }')
  dpms=$(echo $line | awk 'BEGIN {FS="," } { print $12 }')
  dssaver=$(echo $line | awk 'BEGIN {FS="," } { print $13 }')
  anti=$(echo $line | awk 'BEGIN {FS="," } { print $14 }')
  cssc=$(echo $line | awk 'BEGIN {FS="," } { print $15 }')
  before=$(echo $line | awk 'BEGIN {FS="," } { print $16 }')
  after=$(echo $line | awk 'BEGIN {FS="," } { print $17 }')
  mango=$(echo $line | awk 'BEGIN {FS="," } { print $18 }')
  csf=$(echo $line | awk 'BEGIN {FS="," } { print $19 }')
  save=$(echo $line | awk 'BEGIN {FS="," } { print $20 }')
  cdf=$(echo $line | awk 'BEGIN {FS="," } { print $21 }')
  gname=$(echo $line | awk 'BEGIN {FS="," } { print $22 }')
  gicon=$(echo $line | awk 'BEGIN {FS="," } { print $23 }')
  
# save all variables out to csm.conf
cat > $SCRIPT_DIR/csm.conf <<EOF
$contyloc
$ubottle
$bottle
$prog
$sgrf
$rgtc
$gamescope
$gswidth
$gsheight
$gsrefresh
$gsfs
$dpms
$dssaver
$anti
$cssc
$before
$after
$mango
$csf
$save
$cdf
$gname
$gicon
EOF

# gamescope output options: conty gamescope with/without full screen switch, and null
if [ $gamescope == "TRUE" ] && [ $gsfs == "TRUE" ]; then
  gamescope1="$contyloc gamescope -f -W $gswidth -H $gsheight -r $gsrefresh -- "'\'
elif [ $gamescope == "TRUE" ] && [ $gsfs == "FALSE" ]; then
  gamescope1="$contyloc gamescope -W $gswidth -H $gsheight -r $gsrefresh -- "'\'
else
  gamescope1=""
fi

# mangohud output options: with conty mangohud, and null
if [ $mango == "TRUE" ]; then
  mango1="$contyloc mangohud "'\'
else
  mango1=""
fi

# Bottles output options: conty bottles-cli with options, and null
if [ $ubottle == "TRUE" ]; then
  bottle1="$contyloc bottles-cli run -b $bottle -p $prog && "'\'
else
  bottle1=""
fi

# Run linux game file thru conty, run linux game file, and null
if [ $sgrf != "" ] && [ $rgtc == "TRUE" ]; then
  sgrf1="$contyloc $sgrf && "'\'
elif [ $sgrf != "" ] && [ $rgtc == "FALSE" ]; then
  sgrf1="$sgrf && "'\'
else
  sgrf1=""
fi

# use dpms true or false
if [ $dpms == "TRUE" ]; then
  dpms1="xset -dpms"
  dpms2="xset +dpms && "'\'
else
  dpms1=""
  dpms2=""
fi

# use mate screensaver inhibit commands true or false
if [ $dssaver == "TRUE" ]; then
  dssaver1="mate-screensaver-command -i &"
  dssaver2="killall mate-screensaver-command && "'\'
else
  dssaver1=""
  dssaver2=""
fi

# disable AntimicroX while in game true or false
if [ $anti == "TRUE" ]; then
  anti1="killall antimicrox"
  anti2="antimicrox &"
else
  anti1=""
  anti2=""
fi

# custom commands to before and after while in game true or false
if [ $cssc == "TRUE" ]; then
  before1="$before"
  after1="$after && "'\'
else
  before1=""
  after1=""
fi

# check if "create script file" is true or not and output
if [ $csf == "TRUE" ]; then
echo "#!/bin/bash" > $save
echo "" >> $save
[  -z "$before1" ] && echo "Empty" || echo $before1 >> $save
[  -z "$dpms1" ] && echo "Empty" || echo $dpms1 >> $save
[  -z "$dssaver1" ] && echo "Empty" || echo $dssaver1 >> $save
[  -z "$anti1" ] && echo "Empty" || echo $anti1 >> $save
[  -z "$gamescope1" ] && echo "Empty" || echo $gamescope1 >> $save
[  -z "$mango1" ] && echo "Empty" || echo $mango1 >> $save
[  -z "$bottle1" ] && echo "Empty" || echo $bottle1 >> $save
[  -z "$sgrf1" ] && echo "Empty" || echo $sgrf1 >> $save
[  -z "$after1" ] && echo "Empty" || echo $after1 >> $save
[  -z "$dpms2" ] && echo "Empty" || echo $dpms2 >> $save
[  -z "$dssaver2" ] && echo "Empty" || echo $dssaver2 >> $save
[  -z "$anti2" ] && echo "Empty" || echo $anti2 >> $save

chmod +x $save
else
  echo "Desktop File Not Created"
fi

# check if "create desktop file" is true or not and output
if [ $cdf == "TRUE" ]; then
cat > ~/.local/share/applications/$gname.desktop <<EOF
[Desktop Entry]
Name=$gname
Exec="$save"
Icon=$gicon
Type=Application
Categories=Game;
StartupNotify=true
Comment=Start $gname
EOF
chmod +x $gname.desktop
else
  echo "Desktop File Not Created"
fi

# confirmation screens
if [ $cdf == "TRUE" ] && [ $csf == "TRUE" ]; then
  yad --title="Confirm" --text="\nLaunch Script Created as $save\n\nDesktop File Created in ~/.local/share/applications/$gname.desktop\n"
elif [ $cdf == "TRUE" ] && [ $csf == "FALSE" ]; then
  yad --title="Confirm" --text="\nLaunch Script Not Created\n\nDesktop File Created in ~/.local/share/applications/$gname.desktop\n"
elif [ $cdf == "FALSE" ] && [ $csf == "TRUE" ]; then
  yad --title="Confirm" --text="\nLaunch Script Created as $save\n\nDesktop File Not Created\n"
else
  yad --title="Confirm" --text="\nLaunch Script Not Created\n\nDesktop File Not Created\n"
fi

done
