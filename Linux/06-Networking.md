## Network Configuration on CentOs 7 and 8

### Network configuration using nmtui command
[Subnet Calculator](https://www.tunnelsup.com/subnet-calculator/)

IP address classes
```
10.0.0.1/8  Class A
10.0.0.1/16  Class B
10.0.0.1/24  Class C
```
command to start the GUI
```
nmtui
```

![](/images/net1.JPG)

You most Require IPv4 addressing for this connection, Automatically connect and 
Available to all users with the `space bar`

![](/images/net2.JPG)

Enable the NIC
```
ifup <your NIC> Example: ifup ens33
```

### Network configuration through CLI

ens33 = you NIC card

```
ip a
hostname
hostnamectl set-hostname classroom.example.com
nmcli connection show
nmcli connection modify ens33 ipv4.addresses 10.0.0.19/24
nmcli connection modify ens33 ipv4.gateway 10.0.0.1
nmcli connection modify ens33 ipv4.dns '8.8.8.8 8.8.4.4'
nmcli connection modify ens33 ipv4.method manual
nmcli connection modify ens33 connection.autoconnect yes
systemctl restart network
ifconfig ens33 up
cat /etc/sysconfig/network-scripts/ifcfg-ens33
```

**Check the result**
```
/etc/sysconfig/network-scripts/ifcfg-eth0
BOOTPROTO=static
ONBOOT=yes
IPADDR=192.168.1.80
NETMASK=255.255.255.0
GATEWAY=192.168.1.254
DNS1=8.8.8.8
DNS2=8.8.4.4
```