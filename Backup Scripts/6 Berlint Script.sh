# Add Ostania IP for internet connectivity
echo nameserver 192.168.122.1 > /etc/resolv.conf

# Install Bind9 for DNS capabilities
apt-get update
wait
apt-get install bind9 -y
wait

# Initialize DNS
cat /root/bind_local_slave.conf > /etc/bind/named.conf.local

# Initialize Subdomains Transfer
cat /root/name_option_slave.conf > /etc/bind/named.conf.options
cat /root/name_local_slave.conf > /etc/bind/named.conf.local 
mkdir /etc/bind/delegation
cp /etc/bind/db.local /etc/bind/delegation/operation.wise.i01.com
cat /root/bind_operation.conf > /etc/bind/delegation/operation.wise.i01.com

# Restart DNS
service bind9 restart