Firmware images for V9.0.10P2N14D in the release section.

F6107A (F6600P) ZTE Router Root Access and ISP Workaround. Also tested on the F612.

Why This Project?

I didn’t trust the ZTE F6107A GPON router from my ISP. Its opaque firmware and potential for remote control were concerning. Plus, my speeds dropped during peak hours—ISP rate limiting at its finest. Rooting the device confirmed the throttling (see firmware zip that was on my ZTE GPON for more details). 
This project helps you gain root access, bypass restrictions, and replace the GPON with a simpler device like an HSGQ XPON stick and allow your router to do the real work. I use a custom  10G build opensense router with a SFP port already built in which is perfect for an XPON stick.

Getting Root Access

***********IF THE METHOD BELOW DOESN'T WORK TRY USING THE WINDOWS VERSION LINKED [HERE](https://github.com/user-attachments/files/22504482/zteonu3.06_all_en.zip)*******************

Just use the factory method from [here](https://github.com/douniwan5788/zte_modem_tools) like this:

```
git clone https://github.com/douniwan5788/zte_modem_tools
cd zte_modem_tools/
sudo pip install -r requirements
python3 zte_factroymode.py --user "awnfibre" --pass 'fibre@dm!n' --ip 192.168.1.1 --port 80 telnet open```

```
<img width="1000" height="699" alt="Screenshot from 2026-01-27 11-18-23" src="https://github.com/user-attachments/assets/d6c838a4-b8a7-46d3-8c0b-9f6553fcba48" />

<img width="1001" height="230" alt="Screenshot from 2026-01-27 11-19-00" src="https://github.com/user-attachments/assets/e18ac4bb-0ec4-4dba-bbfe-cee7139c1e95" />




Press CTRL+C to exit any active menu—you’re now root!




<img width="742" height="467" alt="Screenshot from 2026-01-27 11-20-52" src="https://github.com/user-attachments/assets/b28c8424-c7cf-4367-bb7a-b0254dc13f85" />


For complete authentication details the GPON sends to the ISP in ASCII

```setmac show2 ```

Now you can clone this to something like an RTL960x (I like the HSGQ XPON stick) and not use this device at all for your home internet. See end for more details. 



But if you must keep using it for some invalid reason.......



Permanently Enable Telnet
To maintain access:
```
sendcmd 1 DB set TelnetCfg 0 TS_Enable 1
sendcmd 1 DB set TelnetCfg 0 Lan_Enable 1
sendcmd 1 DB set TelnetCfg 0 TS_UName root
sendcmd 1 DB set TelnetCfg 0 TS_UPwd root
sendcmd 1 DB addr FWSC 0
sendcmd 1 DB set FWSC 0 ViewName IGD.FWSc.FWSC1
sendcmd 1 DB set FWSC 0 Enable 1
sendcmd 1 DB set FWSC 0 INCName LAN
sendcmd 1 DB set FWSC 0 INCViewName IGD.LD1
sendcmd 1 DB set FWSC 0 Servise 8
sendcmd 1 DB set FWSC 0 FilterTarget 1
upgradetest sfactoryconf 198
sendcmd 1 DB save
```
For Full Superadmin control and bypass the login rights not matched error
clone this repo to a USB stick, place in GPON and run these commands(this will not persist through reboot but changes made as superadmin on the web page will).


Prepare USB stick first. 
```
git clone git@github.com:Blinko1987/F6107A-telnet-root-on-AIS-fiber.git
cd F6107A-telnet-root-on-AIS-fiber/
cp -a /path/to/your/usb
```
Unmount that from your PC and insert into the GPON and run these commands.

```
sendcmd 1 DB set DevAuthInfo 0 Enable 1
sendcmd 1 DB set DevAuthInfo 0 User superadmin
sendcmd 1 DB set DevAuthInfo 0 Pass superadmin
sendcmd 1 DB set DevAuthInfo 0 Level 0
sendcmd 1 DB set DevAuthInfo 0 AppID 1
sendcmd 1 DB save
umount /home/httpd/thinklua 2>/dev/null || true
mount --bind /mnt/usb1_1_1/home/httpd/thinklua /home/httpd/thinklua
killall httpd && httpd &
````
Now you can login as superadmin and pass superadmin. You can confirm level 0 rights after logging in 
by going back to terminal and checking:

```
cat /var/lua_tmp/lua_session/* | grep right
```
Should say something like
```
login_right = "0"
```
I'm using a little trick with the mount --bind flag to change a read only file system to read/write. Doesn't persist through reboot of course. 


You can also disable TR069 (isp spy program)
```
sendcmd 1 DB set MgtServer 0 Tr069Enable 0
sendcmd 1 DB set MgtServer 0 URL http://example.com
sendcmd 1 DB set MgtServer 0 UserName no
sendcmd 1 DB set MgtServer 0 Password no
sendcmd 1 DB save
```

If you want to inspect the device greater you can use some of the static binaries i've also included. 
```
mkdir /tmp/bin
cp -a /mnt/usb1_1_1/bins /tmp/bin
chmod +x /tmp/bin/*
ls /tmp/bin/*
```
Now you can run those like this (busybox binary has many built in already)
```
/tmp/busybox-arm-linux-gnueabi 
BusyBox v1.36.0 (2023-04-24 07:01:50 UTC) multi-call binary.
BusyBox is copyrighted by many authors between 1998-2015.
Licensed under GPLv2. See source distribution for detailed
copyright notices.

Usage: busybox [function [arguments]...]
   or: busybox --list[-full]
   or: busybox --show SCRIPT
   or: busybox --install [-s] [DIR]
   or: function [arguments]...

	BusyBox is a multi-call binary that combines many common Unix
	utilities into a single executable.  Most people will create a
	link to busybox for each function they wish to use and BusyBox
	will act like whatever it was invoked as.

Currently defined functions:
	[, [[, acpid, add-shell, addgroup, adduser, adjtimex, arch, arp,
	arping, ascii, ash, awk, base32, base64, basename, bc, beep,
	blkdiscard, blkid, blockdev, bootchartd, brctl, bunzip2, bzcat, bzip2,
	cal, cat, chat, chattr, chgrp, chmod, chown, chpasswd, chpst, chroot,
	chrt, chvt, cksum, clear, cmp, comm, conspy, cp, cpio, crc32, crond,
	crontab, cryptpw, cttyhack, cut, date, dc, dd, deallocvt, delgroup,
	deluser, depmod, devmem, df, dhcprelay, diff, dirname, dmesg, dnsd,
	dnsdomainname, dos2unix, dpkg, dpkg-deb, du, dumpkmap, dumpleases,
	echo, ed, egrep, eject, env, envdir, envuidgid, ether-wake, expand,
	expr, factor, fakeidentd, fallocate, false, fatattr, fbset, fbsplash,
	fdflush, fdformat, fdisk, fgconsole, fgrep, find, findfs, flock, fold,
	free, freeramdisk, fsck, fsck.minix, fsfreeze, fstrim, fsync, ftpd,
	ftpget, ftpput, fuser, getopt, getty, grep, groups, gunzip, gzip, halt,
	hd, hdparm, head, hexdump, hexedit, hostid, hostname, httpd, hush,
	hwclock, i2cdetect, i2cdump, i2cget, i2cset, i2ctransfer, id, ifconfig,
	ifdown, ifenslave, ifplugd, ifup, inetd, init, insmod, install, ionice,
	iostat, ip, ipaddr, ipcalc, ipcrm, ipcs, iplink, ipneigh, iproute,
	iprule, iptunnel, kbd_mode, kill, killall, killall5, klogd, last, less,
	link, linux32, linux64, linuxrc, ln, loadfont, loadkmap, logger, login,
	logname, logread, losetup, lpd, lpq, lpr, ls, lsattr, lsmod, lsof,
	lspci, lsscsi, lsusb, lzcat, lzma, lzop, makedevs, makemime, man,
	md5sum, mdev, mesg, microcom, mim, mkdir, mkdosfs, mke2fs, mkfifo,
	mkfs.ext2, mkfs.minix, mkfs.vfat, mknod, mkpasswd, mkswap, mktemp,
	modinfo, modprobe, more, mount, mountpoint, mpstat, mt, mv, nameif,
	nanddump, nandwrite, nbd-client, nc, netstat, nice, nl, nmeter, nohup,
	nologin, nproc, nsenter, nslookup, ntpd, od, openvt, partprobe, passwd,
	paste, patch, pgrep, pidof, ping, ping6, pipe_progress, pivot_root,
	pkill, pmap, popmaildir, poweroff, powertop, printenv, printf, ps,
	pscan, pstree, pwd, pwdx, raidautorun, rdate, rdev, readahead,
	readlink, readprofile, realpath, reboot, reformime, remove-shell,
	renice, reset, resize, resume, rev, rm, rmdir, rmmod, route, rpm,
	rpm2cpio, rtcwake, run-init, run-parts, runlevel, runsv, runsvdir, rx,
	script, scriptreplay, sed, seedrng, sendmail, seq, setarch, setconsole,
	setfattr, setfont, setkeycodes, setlogcons, setpriv, setserial, setsid,
	setuidgid, sh, sha1sum, sha256sum, sha3sum, sha512sum, showkey, shred,
	shuf, slattach, sleep, smemcap, softlimit, sort, split, ssl_client,
	start-stop-daemon, stat, strings, stty, su, sulogin, sum, sv, svc,
	svlogd, svok, swapoff, swapon, switch_root, sync, sysctl, syslogd, tac,
	tail, tar, taskset, tc, tcpsvd, tee, telnet, telnetd, test, tftp,
	tftpd, time, timeout, top, touch, tr, traceroute, traceroute6, tree,
	true, truncate, ts, tsort, tty, ttysize, tunctl, ubiattach, ubidetach,
	ubimkvol, ubirename, ubirmvol, ubirsvol, ubiupdatevol, udhcpc, udhcpc6,
	udhcpd, udpsvd, uevent, umount, uname, unexpand, uniq, unix2dos,
	unlink, unlzma, unshare, unxz, unzip, uptime, users, usleep, uudecode,
	uuencode, vconfig, vi, vlock, volname, w, wall, watch, watchdog, wc,
	wget, which, who, whoami, whois, xargs, xxd, xz, xzcat, yes, zcat,
	zcip
```
You can use these tools to inspect programs. I highly suggest you start with mqttd that is running on the device. In short: It's the ISP's remote control/backdoor tool for the GPON router even when TR069 is disabled. Disable it like this

```
sendcmd 1 DB set WAMqttConf 0 Enable 0
sendcmd 1 DB set WAMqttConf 0 url http://example.com
sendcmd 1 DB set WAMqttConf 0 port 0
sendcmd 1 DB save
```

Decode and Encode Config with Updated Keypairs
Use the zte-config-utility to decode and encode the config. For the F6107A (AIS version of F6600P), update the keypairs in zte-config-utility/examples/auto.py:

AISDefAESCBCKey=H6107AV10Key20102021
DefAESCBCIV=ZTE%FN$GponNJ025

![edited2](https://github.com/user-attachments/assets/d165206d-0e59-42c1-b60f-5e915df69f91)


Decode the config:
```
python3 zte-config-utility/examples/auto.py config.bin config.xml --serial YOUR_SERIAL --mac YOUR_MAC
```



![edited](https://github.com/user-attachments/assets/d266b882-1fe1-4ad0-a4a5-5469bf141bd3)


But better idea, build an opensource alternative like an opensense router out of an old dell optiplex with a Broadcom dual SFP card like a 57810s with modified drivers so it can do 2.5G. Get HSGQ stick and clone the info you retrieved using setmac show2 or from the web browser once logged in as superadmin. Works like a charm been doing it for about a year now. Who knows what else this GPON/spywear device is doing. Don't forget AIS probably has the same shady chinese devices running on the backend. I use a "whole house" VPN on my opensense box that tunnelse any device connected to it to a local datacenter VPS box that has a real ISP. It takes quite a bit of work and money to have a safe connection here in this part of the world.  



