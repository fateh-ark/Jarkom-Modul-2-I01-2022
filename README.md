# Jarkom-Modul-1-I02-2022

**Computational Networking Module 1 Practicum Report**

Group Members:

+ Adam Satria Adidarma - 05111942000001
+ Muhammad Fatih Akbar - 5025201117
+ Rangga Aulia Pradana - 5025201154


## Important Links

+ [Questions](https://docs.google.com/document/d/1HfRq4orCSuN1eqGrZGfz_rii9Ag-4p3TInDWUFn0WZo/edit?usp=sharing)
+ [Resources](https://drive.google.com/drive/folders/1SqvSSgirm7O7doKzTVh4YHGWkeRAzsfs?usp=sharing)

## Table Of Contents
- [Jarkom-Modul-1-I02-2022](#jarkom-modul-1-i02-2022)
  - [Important Links](#important-links)
  - [Table Of Contents](#table-of-contents)
  - [Answers](#answers)
    - [Question 1](#question-1)
    - [Question 2](#question-2)
    - [Question 3](#question-3)
    - [Question 4](#question-4)
    - [Question 5](#question-5)
    - [Question 6](#question-6)
    - [Question 7](#question-7)
    - [Question 8](#question-8)
    - [Question 9](#question-9)
    - [Question 10](#question-10)
    - [Question 11](#question-11)
    - [Question 12](#question-12)
    - [Question 13](#question-13)
    - [Question 14](#question-14)
    - [Question 15](#question-15)
    - [Question 16](#question-16)
    - [Question 17](#question-17)
  - [Revisions & Dificulties](#revisions--dificulties)

## Answers

### Question 1


> Make a topology with WISE as DNS Master, Berlint as DNS Slave, Eden will as Web Server, and SSS & Garden as Client!

![Result](https://i.imgur.com/JIVcVZe.png)

#### Network Config

See raw file [here](Backup%20Scripts/1%20GNS3%20Network%20Config.txt)

```
# Inserted to the each node network configuration

# Ostania
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 10.36.1.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 10.36.2.1
    netmask 255.255.255.0

auto eth3
iface eth3 inet static
    address 10.36.3.1
    netmask 255.255.255.0

# SSS
auto eth0
iface eth0 inet static
    address 10.36.1.2
    netmask 255.255.255.0
    gateway 10.36.1.1

# Garden
auto eth0
iface eth0 inet static
    address 10.36.1.3
    netmask 255.255.255.0
    gateway 10.36.1.1

# WISE
auto eth2
iface eth2 inet static
    address 10.36.2.2
    netmask 255.255.255.0
    gateway 10.36.2.1

# Berlint
auto eth0
iface eth0 inet static
    address 10.36.3.2
    netmask 255.255.255.0
    gateway 10.36.3.1

# Eden
auto eth0
iface eth0 inet static
    address 10.36.3.3
    netmask 255.255.255.0
    gateway 10.36.3.1
```

![Connection Test](https://i.imgur.com/Uef5aSS.png)

#### Additional Setups

This is done so that all nodes get internet connectivity for installing dependencies later on.

```sh
# Nano Script.sh in each nodes
# Put into Ostania | Run Iptables
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.36.0.0/16

# Put into other nodes | Add Ostania IP for internet connectivity
echo nameserver 192.168.122.1 > /etc/resolv.conf

# -------------------------

# Append to each node's .bashrc | Run Script.sh each time node is turned on.
chmod +x script.sh
./script.sh
```

### Question 2

> To make it easier to get information about the mission from Handler, help Loid create the main website by accessing **wise.yyy.com** with alias **www.wise.yyy.com** on the wise folder.

#### WISE's Script.sh
Append the following to the file

```sh
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
```

### bind_local.conf

```conf
zone "wise.i01.com" {
	type master;
	file "/etc/bind/wise/wise.i01.com";
};
```

### bind_wisei01com.conf

```bind

; BIND data file for local loopback interface
;
$TTL            604800
@               IN      SOA     wise.i01.com. root.wise.i01.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@                   IN      NS      wise.i01.com.
@                   IN      A       10.36.3.3
www                 IN      CNAME   wise.i01.com. ; Question 2
```

![result](https://i.imgur.com/pCxHAz0.png)


### Question 3

> After that he also wants to create a subdomain **eden.wise.yyy.com** with alias **www.eden.wise.yyy.com** whose DNS is set on WISE and leads to Eden.


Append the following lines to **bind_wisei01com.conf** in WISE.

```bind
eden                IN      A       10.36.3.3 ; Question 3
www.eden            IN      CNAME   eden.wise.i01.com. ; Question 3
```

dont forget to restart dns with `service bind9 restart`.

![result](https://i.imgur.com/Zlihile.png)


### Question 4

> Also create a **reverse domain** for the main domain

### Question 5

> To stay in touch if the WISE server has some problem, make **Berlint also as the DNS Slave for the main domain**

### Question 6

> Because there is a lot of information from Handler, make a special subdomain for operations **operation.wise.yyy.com** with alias **www.operation.wise.yyy.com** delegated from WISE to Berlint with IP leads to Eden on the folder operation

### Question 7

> For more specific information about Operation Strix, create a subdomain via Berlint with access **strix.operation.wise.yyy.com** with alias **www.strix.operation.wise.yyy.com** that leads to Eden

### Question 8

>  After configuring the server, then we need to configure the Web Server. First, with **www.wise.yyy.com** web server. Firstly, Loid needs a web server with DocumentRoot at **/var/www/wise.yyy.com**

### Question 9

>  After that, Loid also needs that url **www.wise.yyy.com/index.php/home** can be **www.wise.yyy.com/home**

### Question 10

> Next, on **www.eden.wise.yyy.com** subdomain, Loid needs an asset storage with DocumentRoot at **/var/www/eden.wise.yyy.com**

### Question 11

> However, on **/public folder**, Loid just wants to do directory listing

### Question 12

> Not only that, Loid also wants to prepare an **error 404.html file on /error folder** to replace the error code on apache 

### Question 13

> Loud also asks Franky to make a virtual host configuration for him. This virtual host aims to be able to access asset files **www.eden.wise.yyy.com/public/js** into **www.eden.wise.yyy.com/js**

### Question 14

> Lois asks that **www.strix.operation.wise.yyy.com** can only be accessed through port **15000** and port **15500**

### Question 15

> with username authentication Twilight and password opStrix and file at **/var/www/strix.operation.wise.yy**

### Question 16

> and everytime **IP Eden accessed** it will automatically redirect to **www.wise.yyy.com**

### Question 17

> Because **www.eden.wise.yyy.com** website have more visitors and a lot of modifications so there are more random pictures, Loid wants to change the image request that has a substring **“eden”** will be directed to eden.png. Help Agent Twilight and WISE Organization to keep the peace!

## Revisions & Dificulties

+ Havent been able to go pass through Question 7
