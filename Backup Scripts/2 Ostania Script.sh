# Run Iptables
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.36.0.0/16