# Add Ostania IP for internet connectivity
echo nameserver 192.168.122.1 > /etc/resolv.conf

# Install Dependencies
apt-get update
wait
apt-get install apache2
wait
service apache2 start
wait
apt-get install php
wait