#!/bin/bash

SERVICE="apache2"
THRESHOLD=80
EMAIL="admin@example.com"

# Check disk usage
USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
if [ $USAGE -gt $THRESHOLD ]; then
  echo "Disk usage high: $USAGE%" | mail -s "Disk Alert on $(hostname)" $EMAIL
fi

# Check if service is running
if ! systemctl is-active --quiet $SERVICE; then
  systemctl restart $SERVICE
  echo "$SERVICE was down and has been restarted on $(hostname)" | mail -s "Service Restarted" $EMAIL
fi

