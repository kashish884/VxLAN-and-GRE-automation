#!/bin/bash

echo 'enter the name of the first namespace'
read ns1
echo 'enter the name of the second namespace'
read ns2

#to delete the vxlan interface at namespace1

sudo ip netns exec $ns1 sudo ip link set vxlan0 down
sudo ip netns exec $ns1 sudo ip link del vxlan0
sudo ip netns exec $ns1 sudo ip link set vxbr1 down
sudo ip netns exec $ns1 ip link del vxbr1


# to delete the vxlan interface at namespace2

sudo ip netns exec $ns2 sudo ip link set vxlan0 down
sudo ip netns exec $ns2 sudo ip link del vxlan0
sudo ip netns exec $ns2 sudo ip link set vxbr2 down
sudo ip netns exec $ns2 ip link del vxbr2

