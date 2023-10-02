#! /bin/bash

# This script write output of nslookup "name of the site" to the index.html 

# This functioun avoid error :
# AH00558: apache2: Could not reliably determine the server's fully qualified domain name,
# using 172.18.0.2. Set the 'ServerName' directive globally to suppress this message
sed -i -e '79 s/^/ServerName localhost\n/;' /etc/apache2/apache2.conf

# This functioun writes the output of nslookup writes in index.html
nslookup $domain > /var/www/html/index.html

service apache2 start

# This function for running a container as a daemon
while true 
do sleep 1
done 