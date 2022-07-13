#!/bin/bash
# YOU NEED TO UPDATE THE FOLLOWING VALUES:
#     PRIVATE_SEGMENT?
#     SECURE_PRIVATE_IP?
#     
iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables -X
iptables -Z INPUT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -s 127.0.0.1 -j ACCEPT
iptables -A INPUT -s PRIVATE_SEGMENT1/24 -j ACCEPT
iptables -A INPUT -s PRIVATE_SEGMENT2/24 -j ACCEPT
iptables -A INPUT -s PRIVATE_SEGMENT3/24 -j ACCEPT
iptables -A INPUT -s PRIVATE_SEGMENT4/24 -j ACCEPT
iptables -A INPUT -s PRIVATE_SEGMENT5/24 -j ACCEPT
iptables -A INPUT -s SECURE_PRIVATE_IP1/32 -p tcp -m multiport --dports 22 -j ACCEPT
iptables -A INPUT -s SECURE_PRIVATE_IP2/32 -p tcp -m multiport --dports 22 -j ACCEPT
iptables -A INPUT -s SECURE_PRIVATE_IP3/32 -p tcp -m multiport --dports 22 -j ACCEPT
iptables -A INPUT -s SECURE_PRIVATE_IP4/32 -p tcp -m multiport --dports 22 -j ACCEPT
iptables -A INPUT -s SECURE_PRIVATE_IP5/32 -p tcp -m multiport --dports 22 -j ACCEPT
# BELOW ARE RULES TO CONTROL TRAFFIC ONLY THROUGH CLOUDFLARE
iptables -A INPUT -s 103.21.244.0/22 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -A INPUT -s 103.22.200.0/22 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -A INPUT -s 103.31.4.0/22 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -A INPUT -s 104.16.0.0/13 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -A INPUT -s 104.24.0.0/14 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -A INPUT -s 108.162.192.0/18 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -A INPUT -s 131.0.72.0/22 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -A INPUT -s 141.101.64.0/18 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -A INPUT -s 162.158.0.0/15 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -A INPUT -s 172.64.0.0/13 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -A INPUT -s 173.245.48.0/20 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -A INPUT -s 188.114.96.0/20 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -A INPUT -s 190.93.240.0/20 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -A INPUT -s 197.234.240.0/22 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -A INPUT -s 198.41.128.0/17 -p tcp -m multiport --dports 443 -j ACCEPT
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
# YOU MIGHT HAVE TO REMOVE IPv6 BELOW IF SYSTEM DO NOT HAVE MODULE
ip6tables -t nat -F
ip6tables -t mangle -F
ip6tables -F
ip6tables -X
ip6tables -Z INPUT
ip6tables -P INPUT DROP
ip6tables -P FORWARD DROP
ip6tables -P OUTPUT DROP
# SET SYSTEM DATE TO EST
timedatectl set-timezone America/Toronto
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo $(date +"%D%T"),"$dt" > /root/fire.log

