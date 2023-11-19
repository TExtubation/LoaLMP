# Linux on a Loki Mini Pro

This is a fairly straight forward guide on how I got Void Linux working* on a Loki Mini Pro (Now discontinued by AYN). (This may work for all the Loki variants, YMMV) As well as some custom scripts, and tweaks I made to make the Linux gaming experience better on my Loki Mini Pro.

There is a caviot * to this at the moment though, currently there is no working audio from the built in speakers of any variant of the Loki. There are people working on the Kernel drivers, but as of writing this it is still a work in progress. However, the headphone jack and bluetooth work just fine to deliver audio.

So why not just use the distro's ([ChimeraOS](https://chimeraos.org/), [Batocera](https://batocera.org/), [JELOS](https://jelos.org/)) designed for this in the first place? Just like most Linux users, I wanted more control. And by installing a distro I already know and trust, I get to have my cake and eat it too, even though I had to make the cake as well.

#### Gearing up for a Journey:

First off, you will need to get a few things to make this transition possible.

Hardware Required to Install Linux:  
    USB-C HUB - [Here is a link](https://www.amazon.com/dp/B08MZZVFX6/) to the one I bought and used.  
    4GB+ Thumb Drive  
    USB Keyboard  
    USB Mouse  

If you plan on backing up the pre-installed Windows 10 system on the Loki you will also need an external hard drive big enough to hold the backup image. I recommend using [Clonezilla](https://clonezilla.org/) to create the backup image as it is fairly simple to use, plus it is free, and there are tons of guides online on how to use it. If you were so inclined, you could also just get another ssd and swap it out so you always have the Windows install if you wanted.

Next, you will need to pick a Linux distro to use. I used [Void Linux](https://voidlinux.org/), as Void is considerable slimmer and more minimalist with its install than most. This frees up a lot of system space and resources that would be better used for gaming. It is however, a lot more hands on than most other distro's. On my Loki MP I used the [voidbuilds.xyz](https://voidbuilds.xyz/) unofficial live installer that includes the Mate desktop environment. It's not as frilly as some DE's, but it is not basic either, and winds up working well as a touch interface. Void also works perfectly with [Appimages](https://appimage.org/) and [Conty](https://github.com/Kron4ek/Conty), the latter of which I use extensively for gaming.

#### First Steps:

This is the point at which if you wanted to save an image of the Windows install, then do so now. There are lots of ways to do this so I will not cover it here. As stated above, If you were so inclined, you could also just get another ssd and swap it out so you always have the Windows install if you wanted.

Before you can install, whichever Linux flavor you have chosen, you must disable TPM in the bios. To do this you have to hook up the usb-c hub so you can connect the thumb drive that has the Linux installer and the usb keyboard. As soon as you turn on the Loki hold down the two lower buttons on either side of  the screen. Holding them down together will get you into the bios. From here you must use the usb keyboard to navigate thru the menu's to disable TPM. You should also select the boot order so the removable drive is able to boot first. Remember to save before exiting.

Follow your instructions for install according to whichever flavor you chose.  
I am going to say something now that may make some people upset, so here goes.  

*There really is no need to do any kind of special or unique system setup. You don't really need drive encryption or different system and home partitions. Hell, you don't even need to setup a swap partition (as I cover that later with a swap file) or even wayland. All you really need is a basic, run of the mill, simple setup. The less custom it is, out of the box, the easier a time you will have if something does happen to go wrong. The whole point is to play games on a handheld pc.*

From here on out I will go through the steps for what I did in Void Linux to get the functionality I wanted on my Loki. Some of the steps I take will not work as they are on other Linux distros. You may have to do some Googling to find the appropriate commands on your distro of choice if necessary. For those using Void there is a fantastic [Documentation site here](https://docs.voidlinux.org/) that can walk you through nearly every aspect of Void.

#### Getting Control of it All:

First things first, I needed to fix the screen orientation on the desktop. Once logged in I opened the *System -> Preferences -> Hardware -> Displays* and changed "Rotation" to the "Left". Hit *apply* and the screen is now considerably easier to read.

Then I needed to uninstall a few things and install a few others. On a terminal I typed 

```
sudo xbps-install -Su
```

This updates the current Void repository and checks for updates.  
Then I went about removing what I did not want.  

```
sudo xbps-remove void-repo-multilib micro firefox
```

After that I installed a few things by typing the following

```
sudo xbps-install git linux-headers void-repo-nonfree dkms pluma grub-customizer onboard antimicrox libantimicrox mate-extra mate-tweaks blueman chrony gtk2-engines mate-menu nano exfat-utils linux-firmware unclutter-xfixes xdotool yad
```

Setting up automatic login should be the second thing tackled, since you don't want to have to login on a machine that does not have a keyboard. On the Mate version of Void I opened a terminal and typed

```
sudo pluma /etc/lightdm/lightdm.conf
```

This opened up the lightdm config file in the pluma text editor (use your text editor of choice if you want). It is a fairly dense file, but I looked through it until I found

```
#autologin-user=
```

I removed the # symbol and entered my username after the = symbol, to look like this

```
autologin-user=myusername
```

Saved file and exit pluma.  
Lets start a few newly installed services if they were not started by default. In Void new services need to be started their first time by hand, and will start every time after on their own. In a terminal type

```
sudo ln -S /etc/sv/bluetoothd /var/service/
sudo ln -S /etc/sv/chronyd /var/service/
```

To check if they are running in Void type the following

```
sudo sv status bluetoothd chronyd

run: bluetoothd: (pid 969) 9895s; run: log: (pid 879) 9896s
run: chronyd: (pid 876) 9896s; run: log: (pid 873) 9896s
```

if the service is not running it will look like this

```
sudo sv status bluetoothd chronyd

fail: bluetoothd: unable to change to service directory: file does not exist
fail: chronyd: unable to change to service directory: file does not exist
```

At this point I noticed that bumping any of the Loki's controller buttons caused the mouse to veer off and stick at the edge of the screen. After a quick reboot, to reset the controller, I opened a terminal and did the following

```
sudo mkdir /etc/X11/xorg.conf.d
sudo touch /etc/X11/xorg.conf.d/50-joystick.conf
sudo pluma /etc/X11/xorg.conf.d/50-joystick.conf
```

And I entered the following into the 50-joystick.conf file

```
Section "InputClass"
    Identifier "joystick catchall"
    MatchIsJoystick "on"
    MatchDevicePath "/dev/input/event*"
    Driver "joystick"
    Option "StartKeysEnabled" "False"   # These Two Lines Disable
    Option "StartMouseEnabled" "False"  # The mouse emulation
EndSection
```

Save file, exit pluma, and give the system another reboot.
Now the built-in controller will not affect the mouse until I setup antimicrox.

SInce I did not have a swap partition I setup a swap file by typing the following into a terminal

```
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo pluma /etc/fstab
```

The final command opens the fstab file in pluma and it should look similar to the following

```
# /proc with hidepid (https://wiki.archlinux.org/index.php/Security#hidepid)
proc	/proc	proc	nodev,noexec,nosuid,hidepid=2,gid=proc	0 0

tmpfs	/tmp	tmpfs	defaults,nosuid,nodev	0 0

# /dev/nvme0n1p2
UUID=78ac6bde-9308-48ce-a056-7056e21daf90	/	ext4	rw,noatime	0	1

# /dev/nvme0n1p1
UUID=AE4C-2136	/boot/efi	vfat	rw,nosuid,nodev,noexec,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro	0	2

```

At the very bottom of the file I added two lines to define the swap file to make it look like this

```
# /proc with hidepid (https://wiki.archlinux.org/index.php/Security#hidepid)
proc	/proc	proc	nodev,noexec,nosuid,hidepid=2,gid=proc	0 0

tmpfs	/tmp	tmpfs	defaults,nosuid,nodev	0 0

# /dev/nvme0n1p2
UUID=78ac6bde-9308-48ce-a056-7056e21daf90	/	ext4	rw,noatime	0	1

# /dev/nvme0n1p1
UUID=AE4C-2136	/boot/efi	vfat	rw,nosuid,nodev,noexec,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro	0	2

# /swap
/swapfile swap swap defaults 0 0
```

Save the file and exit pluma.

At this point the constantly changing rainbow chassis lights were beginning to bother me, so to get control over the lights I did the following in a terminal (note. Void already comes setup with a build environment, other distro's may need additional packages installed)

```
git clone https://github.com/ShadowBlip/ayn-platform.git
cd ayn-platform
make
sudo make dkms
```

This downloads and builds the wonderful [ayn-platform kernel drivers](https://github.com/ShadowBlip/ayn-platform) by [ShadowBlip](https://github.com/ShadowBlip), and because they are DKMS drivers they will automatically be built each time you update to a new Linux Kernel.  
I would now recommend downloading all the files in the Loki folder above, and putting them all in a scripts folder in your Home directory. Even the Loki.png Make sure all the .sh files are executable by doing the following in a terminal

```
chmod +x /home/myusername/scripts/*.sh
```

Now we need to be able to start a few of these scripts from rc.local when the machine starts up so in a terminal type

```
sudo pluma /etc/rc.local
```

And enter the the two scripts locations to the bottom of the like like so

```
#!/bin/sh
# Default rc.local for void; add your custom commands here.
#
# This is run by runit in stage 2 before the services are executed
# (see /etc/runit/2).
/home/myusername/scripts/led_colors.sh
/home/myusername/scripts/loki-batt-check.sh &
```

Save the file and exit pluma.

**led_color.sh**

So now on boot the led_colors.sh script sets the chassis lights to manual mode with a selected color and brightness.

**loki-batt-check.sh & loki-batt-low.sh**

The loki-batt-check.sh file checks the battery status every 60 seconds. If the battery percentage drops below 26% it will run loki-batt-low.sh to flash the chassis lights red a few times and then set the original color back. It will keep doing this every 10 seconds until you plug the Loki into power. It's not necessarily needed, but it works as a good indicator of when you need to plug it in.

Now is a good enough time to setup some other scripts that should start when the desktop starts. *System -> Preferences -> Personal -> Startup Applications* 
The window that opens will have a list of other things Mate will start on boot. Clicking the "+Add" button on the right will bring up another window that lets us add our own commands. I had to add 3-4 new applications to the list, which were the following

```
Name: touch-rotate
Command: /home/myusername/scripts/touch-rotate.sh
Comment:
Delay: 3 seconds
```

```
Name: AntimicroX
Command: /usr/bin/antimicrox
Comment:
Delay: 3 seconds
```

```
Name: Loki-Control
Command: /home/myusername/scripts/yad-loki.sh
Comment:
Delay: 1 seconds
```

And if it's not already there

```
Name: Unclutter
Command: unclutter --hide-on-touch
Comment:
Delay: 1 seconds
```

Also check to make sure that "Blueman Applet" and "Onboard" are also in the list and checked. Uncheck "Screensaver" and close the window.

Now we come to scary territory as we need to edit the sudoers file. The best way to do this is by using visudo in a terminal like so

```
sudo visudo
```

Once open scroll all the way to the bottom of the file create a new line and enter the following

```
ALL ALL=(ALL:ALL) NOPASSWD: /home/myusername/scripts/yad-led.sh, /home/myusername/scripts/loki-bt-fix.sh
```

Now hit "Ctrl+X" and it will ask if you want to save the file, press "Enter" and it should drop you back to the terminal. If you entered something incorrectly visudo will show an error and allow you to go back into the file to correct any mistakes. If you mess up this file and ignore any error visudo warns you of, you may damage your install to the point of having to start over with a reinstall. You have been warned.

Give the system a reboot and you should see a few new icons in the system tray. If you do not see the bluetooth icon in the system tray "Right click" on the Loki icon that is now there. On the menu that appears "Left Click" on "Bluetooth Fix" this will run the **loki-bt-fix.sh** file for you which contains the following command

```
sudo rmmod btusb && sudo modprobe btusb
```

This will remove the btusb Kernel module from the Kernel, and then restart the module. Once this has been done the bluetooth hardware should turn on and start working properly, even after reboots. The bluetooth system tray icon should appear as well. I have had 1 instance of the bluetooth not starting up properly after turning off the bluetooth device and restarting, so I have included this option in the Loki System Control icon to fix it if need be. 

#### Almost there:

As for the other functions of the Loki System Control Icon. Simply "Left Clicking" the icon itself will run the touch-rotate.sh (discussed below) because touch can be finicky at times.

**LED Controls:** lets you customize the color of the Loki's chassis LEDs thru a yad-dialog window. When you make a change in this dialog it is immediately applied to the Loki's LEDs. The new settings are automatically copied into the led_colors.sh file as well, so your new settings are used during the next system boot.

**Custom Conty Script Maker:** This option opens a yad-dialog window that will allow you to create custom game launch scripts that utilize Conty to run things like Gamescope, Bottles, MangoHUD, and the games themselves. It even lets you create .desktop files for your games that should show up under your desktop menu's Game section automatically. The dialog is filled with tooltips on every option so I will not cover them here. I will talk more about Conty below.

**Fix Touch Rotation:** If for whatever reason the screens touch capabilities goes haywire, and is not putting the cursor where it should be (which can and probably will happen at some point) this option runs the touch-rotate.sh file to fix the proper touch screen orientation.

**Bluetooth Fix:** Already covered above

**Quit:** This will completely turn off the Loki System Control program. The only way to start it back up will be to either reboot the system, run the following from a terminal

```
/home/myusername/scripts/yad-loki.sh &
```

or to create a menu item to start the file

```
/home/myusername/scripts/yad-loki.sh
```

I did not create any way to control the Loki's fan, as I never really noticed it much, and when I did, I tweaked the games a bit so it wasn't really audible. The options are still there though from the ayn-platform drivers, but YMMV.  

I also did not feel the need to be able to adjust the TDP of the system, as the system seems to do just fine on its own controlling it. It can be controlled via Ryzenadj, but that is an entirely different beast.  

#### The Games:

Okay, but how are we going to game on this if there is no multiarch, Wine, Steam, Bottles, or Lutris, you might ask?

With a wonderful project by [Kron4ek](https://github.com/Kron4ek) called [Conty](https://github.com/Kron4ek/Conty). It is an unprivileged Linux container packed into a single portable executable that contains everything x64 and x86 related that we need for gaming on Linux.

In essence this saves us from installing everything listed below and then having to make sure it is all configured to run properly. And it's all in a single file we can simply place in our home directory.

The standard conty.sh contains Wine-GE, Steam, Lutris, PlayOnLinux, GameHub, Minigalaxy, Legendary, Bottles, MultiMC5, MangoHud, Gamescope, RetroArch, Sunshine, OBS Studio, OpenJDK, Firefox, base-devel, gcc, mingw-w64-gcc, meson, cmake, Qbittorrent.

The conty_lite.sh file contains all of the above minus base-devel, gcc, mingw-w64-gcc, firefox, meson, cmake, jre-openjdk, multimc5 and qbittorrent.

Downloads of the latest version can be found [here](https://github.com/Kron4ek/Conty/releases/latest).

I personally use the conty_lite.sh version but if you happen to need openjdk for anything you may want to download the standard conty.sh version.

Copy the contents of the Conty folder I have provided above into a folder of your choosing. I placed mine into a folder in my home directory called Conty (I know, real original). I also copied the latest version of conty_lite.sh to this folder as well. Make sure all .sh files are executable with the following

```
chmod +x /home/myusername/Conty/*sh
```

The scripts and icons contained in the folder will allow you to easily setup desktop launch icons if you so desired, for Bottles, Steam, Lutris, or PlayOnLinux. All the scripts will need to be altered to contain the true path you use to the location of the Conty version you downloaded.

From these scripts Steam can be launched in big picture mode, but the script will also kill antimicrox before starting as the Loki's built in controller works just fine within Steam without it. It will also restart antimicrox after Steam is closed.

Each program provided may require minor settings to be tweaked once run, but nothing like trying to set them up from scratch.

For windows games I have previously downloaded, I run them thru Bottles, and not Lutris. As I have never had good luck with Lutris on its own. With Bottles, I have setup a single Misc bottle for gaming and installed the average dependencies into it that most games would use. I then add shortcuts within that bottle to start the games. This way I can utilize the Custom Conty Script Maker in the Loki System Control icon to create scripts that can start the games for me, instead of having to open Bottles and run the games from its interface. Again, this lets me fine tune the scripts to stop and start anything I want before and after running the games like antimicrox or inhibit the mate-screensaver so the screen doesn't go black or dim from what it thinks is inactivity.

Even x86 Linux games like the original Portal, Portal 2, or Geometry Wars 2 can be run thru Conty as it has all the necessary x86 libraries that are not installed on the regular Void system. 

Every game can also utilize Gamescope thru Conty to set a custom resolution and refreshrate so more powerful games can be run at smaller resolutions in order to run better, as well as MangoHUD to see fps and utilization options. There is so much that can be done with Conty on the Loki it's mind bending.

#### Tweaks:

We are officially nearing the end, so I thought I would give you some tweaks to help in the final stretch.

The Loki does not seem to like to display the desktop at anything other than 1920x1080 rr-60. Trying to change it leads to a black display. That is why Gamescope is so helpful when it comes to sizing down the games to run better.

Also setting the display to a 200% scale seems to make everything much more touch friendly, and does not hinder the games at all.

Changing the default "Mate Application Menu" to the "Advanced Mate Menu" allows you to scale up the icons in the menu for better touch capability.

Antimicrox is able to use the Loki's built in controller to control the on-screen mouse better than just letting the system do it. Plus it lets you setup any button to do anything you want. For me I set the top left (Back) button next to the screen to do "Alt-L+F4" so that whenever the mouse is on a window I can press that button to close that window. It's easier than using the mouse or trying to tap the x to close a window. The left stick controls mouse movement, while the right stick up and down controls the mouse scroll wheel. "A button" is "Left Click", while "B button" is "Right Click".

In *Menu -> System -> Preferences -> Hardware -> Keyboard Shortcuts* I have setup the bottom right button next to the screen so that when it is pressed it runs onboard and pulls up the on-screen keyboard.

If you are wanting to do some experimenting on the Loki but do not want to go thru the hassle of plugging in the hub as well as a keyboard and mouse. Then install x11vnc

```
sudo xbps-install x11vnc
```

You can then run from a terminal or create a menu entry to run

```
x11vnc -scale 5/8 -noxdamage -repeat -forever
```

And connect to your Loki thru vnc on an another pc.

#### The End:

Well here it is. You made it. I would love to hear your tips and tricks if you find any, and as I learn more I'll post it here. I hope this helps others.
