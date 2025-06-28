# Docker container with metasploit.
#
FROM kalilinux/kali-rolling@sha256:a018ff12a3829fccbb70c11ba68de2174add792fd474bc6dc0e2e26620d3771d
LABEL maintainer="Tom Eklöf <tom@linux-konsult.com>" author="Tom Eklöf <tom@linux-konsult.com>"

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get -y update
RUN apt-get -y --no-install-recommends install \
    ruby \
    metasploit-framework
RUN rm -rf /var/lib/apt/lists/*

# Copy init and entrypoint scripts
COPY ./init.sh /init.sh
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /init.sh /entrypoint.sh

# Health check command
HEALTHCHECK CMD /usr/share/metasploit-framework/msfconsole -h || exit 1

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/init.sh"]
