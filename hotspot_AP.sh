#!/bin/sh

DEBUG=$1
TABLES="filter nat mangle"
EXTIF="wlan0"
INIF="eth0"
INNET="192.168.112.0/24"
REDIRPAGE="192.168.112.1:80"

#Clean iptables
for tb in $TABLES 
do
    # -F ：清除所有的已訂定的規則
    iptables -t $tb -F
    # -X ：殺掉所有使用者 "自訂" 的 chain (應該說的是 tables ）囉
    iptables -t $tb -X
    # -Z ：將所有的 chain 的計數與流量統計都歸零
    iptables -t $tb -Z
done

#Phase 1 (WIRELESS ROUTER): 
# use ipatbles forwarding and masquerading for NAT, 
# also set net.ipv4.ip_forward=1 in /etc/sysctl.conf
iptables -t filter -A FORWARD -s $INNET -i $INIF -o $EXTIF -j ACCEPT
iptables -t filter -A FORWARD -d $INNET -i $EXTIF -o $INIF -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t filter -P FORWARD DROP
iptables -t nat -A POSTROUTING -s $INNET -o $EXTIF -j MASQUERADE

# Phase 2 (CAPTIVE PORTAL):
# add a new user-defined chain in mangle table
iptables -t mangle -N internet
iptables -t mangle -A PREROUTING -i $INIF -p tcp -m tcp --dport 80 -j internet
iptables -t mangle -A internet -j MARK --set-mark 99
iptables -t nat -A PREROUTING -i $INIF -p tcp -m mark --mark 99 -m tcp --dport 80 -j DNAT --to-destination $REDIRPAGE
iptables -t nat -A PREROUTING -i $INIF -p tcp -m mark --mark 99 -m tcp --dport 443 -j DNAT --to-destination $REDIRPAGE
