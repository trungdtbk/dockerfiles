Without any configuration, it works as a normal L2 learning switch.
All interfaces are added to a single OVS inside the container

Environments:
CTLR_ADDR: Set the controller, e.g. CTLR_ADDR=192.168.1.100:6653
DP_ID: set the dp_id for the OVS, default = random. e.g. DP_ID=0123456789ABCDEF

When CTLR_ADDR is set, the first port (eth0, normally) is used to connect to the
controller. All other ports are added to the OVS
