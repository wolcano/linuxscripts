@echo off
setlocal enabledelayedexpansion

::::
::  Controls TP-LINK HS100,HS110, HS200 wlan smart plugs
::  Tested with HS100 firmware 1.0.8
::
::  Credits to Thomas Baust for the query/status/emeter commands
::
::  Author George Georgovassilis, https://github.com/ggeorgovassilis/linuxscripts

:: requirements
::   base64.exe (from unxtools https://www.fourmilab.ch/webtools/base64/)
::   ncat.exe (from nmap installation https://nmap.org/download.html)


set CMD=%1
set HSIP=%2
set HSPORT=%3

::set NC_BIN="C:\Program Files (x86)\nmap\ncat.exe"
set NC_BIN=ncat.exe
set BASE64_BIN=base64.exe

:: default port is 9999
if x!HSPORT!==x (
	set HSPORT=9999
)

:: encoded {"system":{"set_relay_state":{"state":1}}}
set payload_on=AAAAKtDygfiL/5r31e+UtsWg1Iv5nPCR6LfEsNGlwOLYo4HyhueT9tTu36Lfog==

:: encoded {"system":{"set_relay_state":{"state":0}}}
set payload_off=AAAAKtDygfiL/5r31e+UtsWg1Iv5nPCR6LfEsNGlwOLYo4HyhueT9tTu3qPeow==

:: encoded { "system":{ "get_sysinfo":null } }
set payload_query=AAAAI9Dw0qHYq9+61/XPtJS20bTAn+yV5o/hh+jK8J7rh+vLtpbr

:: the encoded request { "emeter":{ "get_realtime":null } }
set payload_emeter=AAAAJNDw0rfav8uu3P7Ev5+92r/LlOaD4o76k/6buYPtmPSYuMXlmA==


if x!CMD!==xon (
	set REQ_B64=!payload_on!
)

if x!CMD!==xoff (
	set REQ_B64=!payload_off!
)

if NOT x!REQ_B64!==x (
	echo !REQ_B64! | !BASE64_BIN! --decode |!NC_BIN! -n -i 100ms -w 200ms !HSIP! !HSPORT! >NUL 2>&1
) else (
	echo Command not supported.
)

