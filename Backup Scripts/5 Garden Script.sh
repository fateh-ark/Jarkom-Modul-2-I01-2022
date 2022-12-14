# Add Ostania IP for internet connectivity
echo nameserver 192.168.122.1 > /etc/resolv.conf

# DNSUtils for checking
apt-get update
wait
apt-get install dnsutils
wait
host -t PTR "10.36.3.3"

# Install Lynx to access the web
apt-get update
wait
apt-get install lynx
wait