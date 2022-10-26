# Add Ostania IP for internet connectivity
echo nameserver 192.168.122.1 > /etc/resolv.conf

# Install Lynx to access the web
apt-get update
wait
apt-get install lynx
wait