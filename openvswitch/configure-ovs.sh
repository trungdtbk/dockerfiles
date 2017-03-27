#!/bin/bash
DP_ID=`printenv DP_ID`
CTLR_ADDR=`printenv CTLR_ADDR`

sleep 3
ovs-vsctl --no-wait init

if [ -z "${DP_ID}" ]; then
    hex=("0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "A" "B" "C" "D" "E" "F")
    RANDOM=$$$(date +%s)
    DP_IP=""
    for i in `seq 16`;
    do
        digit=${hex[$RANDOM % ${#hex[@]}]}
        DP_ID="${DP_ID}${digit}"
    done
fi

ovs-vsctl add-br s1
for i in `ifconfig -a | sed -n '/eth[1-9]/p' | cut -c 1-6`
do
    echo `ovs-vsctl add-port s1 "$i"`
done
ovs-vsctl set Bridge s1 other-config:datapath-id=$DP_ID
ovs-vsctl set Bridge s1 protocols=OpenFlow13


if [ -z "${CTLR_ADDR}" ]; then
    ovs-ofctl -Oopenflow13 add-flow s1 actions=normal
else
    ovs-vsctl set-controller s1 tcp:$CTLR_ADDR
fi
exit 0
