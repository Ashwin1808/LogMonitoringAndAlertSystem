#!/bin/bash

# Define the log file and keywords to monitor
LOG_FILE="/var/log/application.log"
KEYWORDS=("ERROR" "CRITICAL")
ALERT_EMAIL="admin@example.com"

# Monitor the log file for changes
tail -Fn0 "$LOG_FILE" | while read -r line; do
    for keyword in "${KEYWORDS[@]}"; do
        if [[ "$line" == *"$keyword"* ]]; then
            # Log the alert to a separate file
            echo "$(date): Alert - $line" >> alert.log
            
            # Send an email alert (requires mailutils)
            echo "Log Alert: $line" | mail -s "Log Alert: $keyword Found" "$ALERT_EMAIL"
            
            # Print alert to console
            echo "Alert sent for keyword: $keyword"
        fi
    done
done
