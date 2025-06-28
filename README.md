# Metasploit Docker Image

This Docker image contains Metasploit framework.

## Build and Run

To build the image, run:

```bash
docker build -t linuxkonsult/kali-metasploit .
```

To run the container:

```bash
docker run --rm -it linuxkonsult/kali-metasploit
```

## Automated Updates

The container will automatically update the Metasploit framework on startup. You can view the update logs at `/var/log/metasploit-update.log`.

## Example Usage

### Interactive Shell

To start the image and get into an interactive `msfconsole` shell:

```bash
docker run --rm -it linuxkonsult/kali-metasploit
```

### Web Application Scanning

To run a `joomla_plugins` scan directly against a target:

```bash
docker run --rm -it linuxkonsult/kali-metasploit msfconsole -x "use auxiliary/scanner/http/joomla_plugins; set RHOSTS 127.0.0.1; set VHOST example.com; set THREADS 3; run; exit"
```

### Host Scanning & Exploitation

To perform a TCP port scan on the Docker host from within the container, you can use host networking:

```bash
docker run --rm -it --net=host linuxkonsult/kali-metasploit msfconsole -x "use auxiliary/scanner/portscan/tcp; set RHOSTS 127.0.0.1; run; exit"
```

You can also search for exploits directly. For example, to find exploits for the `vsftpd` FTP server:

```bash
docker run --rm -it linuxkonsult/kali-metasploit msfconsole -x "search vsftpd; exit"
```

To check for the "Shellshock" vulnerability on a local web server running on the host:

```bash
docker run --rm -it --net=host linuxkonsult/kali-metasploit msfconsole -x "use auxiliary/scanner/http/cgi_bash_env; set RHOSTS 127.0.0.1; set TARGETURI /cgi-bin/vulnerable.sh; run; exit"
```

### Full Vulnerability Scan (Database-Backed)

For a comprehensive vulnerability scan, the recommended workflow is to use a dedicated scanner like **Nmap** for discovery and then import the results into the Metasploit database for analysis and exploitation. This approach leverages Nmap's superior speed and scanning features.

**Step 1: Scan with Nmap**

First, perform a detailed Nmap scan on your target and save the output in XML format. The `-A` flag enables OS detection, version detection, script scanning, and traceroute.

```bash
nmap -A -oX nmap_scan.xml <target_ip>
```

**Step 2: Import and Analyze in Metasploit**

Next, create a Metasploit resource script (`exploit.rc`) to automate the import and analysis process. This script will import the Nmap results and list the identified vulnerabilities, allowing you to choose the appropriate exploits.

Create a file named `exploit.rc` with the following content:
```
db_import /scans/nmap_scan.xml
echo "[*] Nmap scan imported successfully."
echo "[*] Listing identified vulnerabilities..."
vulns
echo "[*] Use the information above to search for and run relevant exploits."
```

Now, run the container, mounting your current directory (containing the scan results and script) to `/scans` inside the container:

```bash
docker run --rm -it -v ${PWD}:/scans linuxkonsult/kali-metasploit msfconsole -r /scans/exploit.rc
```