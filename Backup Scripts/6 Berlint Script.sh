# Add Ostania IP for internet connectivity
echo nameserver 192.168.122.1 > /etc/resolv.conf

# Install Bind9 for DNS capabilities
apt-get update
wait
apt-get install bind9 -y
wait

# Initialize DNS
cat /root/bind_local_slave.conf > /etc/bind/named.conf.local
mkdir /etc/bind/wise
cp /etc/bind/db.local /etc/bind/wise/wise.i01.com
cat /root/bind_wisei01com.conf > /etc/bind/wise/wise.i01.com