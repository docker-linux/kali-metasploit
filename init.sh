#!/bin/bash

# /etc/init.d/postgresql start
echo deb http://http.kali.org/kali kali-rolling main contrib non-free >> /etc/apt/sources.list
/usr/share/metasploit-framework/msfupdate
/usr/share/metasploit-framework/msfconsole			# Throw us into the Metasploit console
