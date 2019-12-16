#!/bin/bash

echo "enter the name of the first namespace"
read ns1
echo "enter the name of the second namespace"
read ns2
echo "enter the IP address of the local interface for this tunnel in the first namespace"
read local1
echo "enter the IP address of the remote interface of the first namespace"
read remote1

echo "enter the name of the interface in the namespace 1 connected to the VM"
read ve1
echo "enter the name of the interface in the namespace1 connected to the transit namespace"
read ve2
echo "enter the IP address of the interface connected to namespace1 in transit namespace"
read via1
echo "enter the subnet Id for this interface"
read sb1
echo "enter the subnet ID of the first VM"
read vm1ip

echo "enter the name of the interface in the namespace2 connected to the VM"
read ve6
echo "enter the name of the interface in the namespace2 connected to the transit namespace"
read ve5
echo "enter the IP address of the interface connected to namespace2 in transit namespace"
read via2
echo "enter the subnet ID for this interface"
read sb2
echo "enter the subnet ID of the second VM"
read vm2ip





# to create gretun at ns1

sudo ip netns exec $ns1 sudo ip tunnel add gretun1 mode gre local $local1 remote $remote1
sudo ip netns exec $ns1 sudo ip link set dev gretun1 up
sudo ip netns exec $ns1 sudo ip route add $vm2ip dev gretun1
sudo ip netns exec $ns1 ip route add $sb2 via $via1 dev $ve2
sudo ip netns exec $ns1 ip route add $vm1ip dev $ve1

#to create gretun at ns2

sudo ip netns exec $ns2 sudo ip tunnel add gretun1 mode gre local $remote1 remote $local1
sudo ip netns exec $ns2 sudo ip link set dev gretun1 up
sudo ip netns exec $ns2 sudo ip route add $vm1ip dev gretun1
sudo ip netns exec $ns2 ip route add $sb1 via $via2 dev $ve5
sudo ip netns exec $ns2 ip route add $vm2ip dev $ve6


