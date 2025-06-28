#!/bin/bash

# Run Metasploit update with error handling and logging
if apt-get update && apt-get install -y metasploit-framework &> /var/log/metasploit-update.log; then
    echo "Metasploit update successful."
else
    echo "Metasploit update failed. Check /var/log/metasploit-update.log for details."
    exit 1
fi

# Start PostgreSQL and initialize the database
echo "Starting PostgreSQL and initializing Metasploit database..."
/etc/init.d/postgresql start
msfdb init
echo "Database initialization complete."
