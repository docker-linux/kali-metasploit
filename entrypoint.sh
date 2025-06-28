#!/bin/bash

# Run updates during container startup
if /init.sh &> /var/log/metasploit-init.log; then
    echo "Initialization successful"
else
    echo "Initialization failed. Check /var/log/metasploit-init.log for details."
    exit 1
fi

# Execute the CMD from the Dockerfile
exec "$@"