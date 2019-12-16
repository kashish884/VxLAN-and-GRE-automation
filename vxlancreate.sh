#!/bin/bash

#user defined inputs for the namespace 1 for vxlan operation

echo "enter the name of the first namespace"
read ns1
echo "enter the name of the interface in namespace1 connected to the VM"
read ve1
echo "enter the name of the interface in namespace1 connected to the transit namespace"
read ve2
echo "enter the IP address of the remote interface"
read remote1
echo "enter the subnet ID for this remote interface"
read sb2
echo "enter the IP address of the interface present in the transit namespace that is connected to namespace1"
read via1


#user defined inputs for the namespace 2 for vxlan

echo "enter the name of the second namespace"
read ns2
echo "enter the name of the interface in namespace2 connected to the VM"
read ve6
echo "enter the name of the interface in namespace2 connected to the transit namespace"
read ve5
echo "enter the IP address of the remote interface"
read remote2
echo "enter the subnet ID for this interface"
read sb1
echo "enter the IP address of the interface in transit namespace that is connected to namespace2"
read via2


echo "enter the subnet ID of the VM's"
read vmip

# to create vxlan interface at namespace 1

sudo ip netns exec $ns1 brctl addbr vxbr1
sudo ip netns exec $ns1 ip link set vxbr1 up
sudo ip netns exec $ns1 ip link add name vxlan0 type vxlan id 42 dev $ve2 remote $remote1 dstport 4789
sudo ip netns exec $ns1 ip link set dev vxlan0 up
sudo ip netns exec $ns1 brctl addif vxbr1 $ve1 vxlan0
sudo ip netns exec $ns1 ip route add $sb2 via $via1 dev $ve2
sudo ip netns exec $ns1 ip route add $vmip dev $ve1


# to create vxlan interface at namespace 2

sudo ip netns exec $ns2 brctl addbr vxbr2
sudo ip netns exec $ns2 ip link set vxbr2 up
sudo ip netns exec $ns2 ip link add name vxlan0 type vxlan id 42 dev $ve5 remote $remote2 dstport 4789
sudo ip netns exec $ns2 ip link set dev vxlan0 up
sudo ip netns exec $ns2 brctl addif vxbr2 $ve6 vxlan0
sudo ip netns exec $ns2 ip route add $sb1 via $via2 dev $ve5
sudo ip netns exec $ns2 ip route add $vmip dev $ve6






