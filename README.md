F6107A (F6600P) ZTE Router Root Access and ISP Workaround

Why This Project?

I didn’t trust the ZTE F6107A GPON router from my ISP. Its opaque firmware and potential for remote control were concerning. Plus, my speeds dropped during peak hours—ISP rate limiting at its finest. Rooting the device confirmed the throttling (see firmware zip that was on my ZTE GPON for more details). 
This project helps you gain root access, bypass restrictions, and replace the GPON with a simpler device like an HSGQ XPON stick and allow your router to do the real work. I use a custom  10G build opensense router with a SFP port already built in which is perfect for an XPON stick.

Getting Root Access

Big thanks to rssor for the original exploit!

Edit pwn.py (in pwn/ folder) with your router’s IP and your machine’s MAC address.
Run pwn.py to exploit the router and generate random login credentials.
Log in with those credentials.
Press CTRL+C to exit any active menu—you’re now root!

Useful Commands for Replacement (e.g., with HSGQ XPON stick):


Displays all settings for cloning to a new device such as the HSGQ.
setmac show2 


Evidence of ISP Rate Limiting

The pwn.py and rsspwn.py scripts (in pwn/ folder) exploit vulnerabilities to access the router’s configuration. Logs and QoS settings revealed bandwidth caps during peak hours (6 PM–11 PM). The V9.0.10P2N14D.zip file contains the extracted firmware, showing ISP scripts that adjust traffic shaping by time. Root access lets you disable these restrictions.

Permanently Enable Telnet
To maintain access:
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
sendcmd 1 DB saveasy

Add Superadmin User
For full control:
sendcmd 1 DB set DevAuthInfo 5 Enable 1
sendcmd 1 DB set DevAuthInfo 5 User superadmin
sendcmd 1 DB set DevAuthInfo 5 Pass superadmin
sendcmd 1 DB set DevAuthInfo 5 Level 0
sendcmd 1 DB set DevAuthInfo 5 AppID 1
sendcmd 1 DB saveasy

Decode and Encode Config with Updated Keypairs
Use the zte-config-utility to decode and encode the config. For the F6107A (AIS version of F6600P), update the keypairs in zte-config-utility/examples/auto.py:

AISDefAESCBCKey=H6107AV10Key20102021
DefAESCBCIV=ZTE%FN$GponNJ025

![edited2](https://github.com/user-attachments/assets/d165206d-0e59-42c1-b60f-5e915df69f91)


Decode the config:
python3 zte-config-utility/examples/auto.py config.bin config.xml --serial YOUR_SERIAL --mac YOUR_MAC

Make the changes you desire then:

Encode the config:
python3 zte-config-utility/examples/encode.py --signature ZTE%FN$GponNJ025 --serial "YOUR_SERIAL" --signature 'F6107A V9-main' --include-header --little-endian-header config3.xml config4.bin

Modify Payload Type:Open the encoded config4.bin in a hex editor (e.g., wxHexEditor). At offset 0x161 (as seen in the screenshot), change the payload type from 04 to 05. Save the file.
Next Steps
With root access, disable ISP throttling, extract configs, or replace the GPON. The pwn/ folder and V9.0.10P2N14D.zip provide tools and firmware for further exploration. Swap this router for an open-source alternative and take back control of your network!


![edited](https://github.com/user-attachments/assets/d266b882-1fe1-4ad0-a4a5-5469bf141bd3)

