# Docker container with metasploit.
#
# Use Kali Linux base image (2.0)
FROM kalilinux/kali-linux-docker
MAINTAINER Tom Eklöf "tom@linux-konsult.com"

ENV DEBIAN_FRONTEND noninteractive

ADD ./init.sh /init.sh

# Install metasploit
RUN apt-get -y update ; apt-get -y --force-yes install ruby metasploit-framework

# Attach this container to stdin when running, like this:
# docker run -t -i linux/kali/metasploit
CMD /init.sh
