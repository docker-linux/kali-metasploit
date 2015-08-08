Examples
--------------
To start the image and get into an interactive msfconsole shell:
`docker run -t -i linuxkonsult/kali-metasploit`

To run a joomla_plugins scan directly:
`docker run -t -i linuxkonsult/kali-metasploit msfcli auxiliary/scanner/http/joomla_plugins RHOSTs=127.0.0.1 VHOST=example.com THREADS=3 E`
