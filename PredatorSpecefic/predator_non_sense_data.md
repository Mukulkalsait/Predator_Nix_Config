PH315- 53-72W3’
PH16-71 – add support +2
PHN16-71 – add support
Link to this document: NH-QCYSI-008

Temp Control:

CoolBoost Toggle register: 0x10
00 to turn off
01 to turn on

Turbo mode:
set 0x21 from 50 (auto) to 60 for GPU Fan 70 for manual mode
set 0x22 from 54 (auto) to 58 for CPU Fan 5C for manual mode
set 0x5BRegister 50 0B for turbo led
Control fan speed 20 0C 01 - 05

Manual Fan Control:
0x37 CPU Fan 00 for least and 64 for max
0x3A GPU Fan 00 for least and 64 for max

Keyboard Control: from 00 to 01 for Turbo LED
Register 50 0B for turbo led
Control fan speed 20 0C 01 - 05

Manual Fan Control:
0x37 CPU Fan 00 for least and 64 for max
0x3A GPU Fan 00 for least and 64 for max

Keyboard Control:

0x1F for enable toggle
VVVV
Zone R G B Enable
1000 3C 3D 3E 1---
0100 3F 40 41 -1--
0010 42 43 44 --1-
0001 45 46 47 ---1

The above are valid only when Static is selected as lighting style

For Static brightness control use reg 0x19
0x00 - off
0x19 - level 1
0x32 - level 2
0x4B - level 3
0x64 - level 4 Max

Disable Trackpad:
Set 0xA1 to 04 to disable trackpad
Set 0xA1 to 00 to enable trackpad

Fan Profile Aggressiveness/GPU OC: set 0x29
0x00: Normal
0x01: Fast
0x02: Extreme

Display OverDrive set: 0x21 second 4 bits
0x_0: OD off
0x_8: OD on

30 second keyboard backlight off thing, set: 0x06
0x00: off
0x1E: on

Battery Charge Limit to 80%: Set 0x03
0x71
: Limit on
0x31: Limit off
