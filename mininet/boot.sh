#!/bin/bash

CTLR_ADDR=`printenv CTLR_ADDR`

if [ -z "${CTLR_ADDR}" ]; then
    CTLR_ADDR=127.0.0.1:6633
fi

service openvswitch-switch start

ovs-vsctl add-br s1
for i in `ifconfig -a | sed -n '/eth[1-9]/p' | cut -c 1-6`
do
    echo `ovs-vsctl add-port s1 "$i"`
done
ovs-vsctl set Bridge s1 other-config:datapath-id=0000000000000001
ovs-vsctl set Bridge s1 protocols=OpenFlow13
ovs-vsctl set-controller s1 tcp:$CTLR_ADDR

bash
