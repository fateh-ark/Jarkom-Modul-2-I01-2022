# Add Ostania IP for internet connectivity
echo nameserver 192.168.122.1 > /etc/resolv.conf

# Install Bind9 for DNS capabilities
apt-get update
wait
apt-get install bind9 -y
wait

# Initialize DNS
cat /root/bind_local.conf > /etc/bind/named.conf.local
mkdir /etc/bind/wise
#
cat /root/bind_wisei01com.conf > /etc/bind/wise/wise.i01.com

# Initialize Reverse DNS
cp /etc/bind/db.local /etc/bind/wise/3.36.10.in-addr.arpa
cat /root/bind_reversedns.conf > /etc/bind/wise/3.36.10.in-addr.arpa

# Initialize Subdomains Transfer
cat /root/name_option.conf > /etc/bind/named.conf.options
cat /root/name_local.conf > /etc/bind/named.conf.local 

# Restart DNS
service bind9 restart