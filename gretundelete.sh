#!/bin/bash

echo "enter the name of the first namespace"
read ns1
echo "enter the name of the second namespace"
read ns2

# to delete the interface at ns1

sudo ip netns exec $ns1 ip link set dev gretun1 down
sudo ip netns exec $ns1 ip link del gretun1

# to del the interface at ns2

sudo ip netns exec $ns2 ip link set dev gretun1 down
sudo ip netns exec $ns2 ip link del gretun1
