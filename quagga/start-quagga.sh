#!/bin/bash

# entry point script:
# set up bgpd.conf with configuration via environment variable
# ASN=65000
# NEIGHBOR1=10.0.0.1 remote-as 1
# NEIGHBOR2=10.0.0.2 remote-as 2
# NEIGHBOR3=10.0.0.3 remote-as 3

BGP_CONF=/etc/quagga/bgpd.conf
ZEBRA_CONF=/etc/quagga/zebra.conf

ASN=`printenv ASN`

if [ -z "${ASN}" ]; then
    ASN=65000
fi
#cat > $ZEBRA_CONF <<EOF
#!------Zebra configuration-----
#password 123
#enable password 123
#log stdout
#line vty
#exec-timeout 0 0
#!
#EOF

#cat > $BGP_CONF <<EOF
#!------BGP configuration-----
#password 123
#enable password 123
#!
#router bgp $ASN
#EOF
#IFS=$'\n'
#for nb in `printenv | grep NEIGHBOR | sed 's/^NEIGHBOR[0-9]=//'`; do
#    print $nb
#    cat >> $BGP_CONF <<EOF
#   neighbor $nb
#EOF
#done

echo "Starting daemons."
for svc in zebra bgpd isisd ospfd ospf6d ripd ripngd; do
 if [ -f /etc/quagga/${svc}.conf ]; then
  echo "Starting ${svc}."
  $svc &
 fi
done
