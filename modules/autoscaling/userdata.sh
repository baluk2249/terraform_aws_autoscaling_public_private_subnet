#!/bin/bash
# Install Nginx
apt-get update
apt-get install -y nginx

# Get the instance ID and write it to the index.html file
INSTANCE_ID=$(hostname)
echo "<html><body><h1>hostname: $INSTANCE_ID</h1></body></html>" > /var/www/html/index.html

# Start Nginx
systemctl start nginx
systemctl enable nginx