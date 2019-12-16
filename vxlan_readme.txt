Configure the topology as per the question

-- created a bridge to connect the VM's to the namespaces
-- used veth pairs for the links
-- don't have to configure any additional routes 
-- the vm's should belong to the same subnet.
##-------The script vxlancreate.sh creates the vxlan tunnel

To run the script 
use command: chmod 755 vxlancreate.sh #to give permission to execute
           : ./vxlancreate.sh         #to execute the script

When the command is run it asks for the user inputs

1. enter the name of the first namespace
	 : give the name of the namespace in which the user wishes to create the tunnel --eg:ns1
2. enter the name of the interface in namespace1 connected to the VM
	 : give the name of the interface as it is created --eg:veth1
3: enter the name of the interface in namespace1 connected to the transit namespace
	 : give the name of the interface as it is created --eg:veth2
4: enter the IP address of the remote interface
	 : give the IP address of the interface(in the second namespace) where the tunnel ends --eg:110.0.3.2
5: enter the subnet ID of the this remote interface
	 : give the remote interface's subnet ID
6: enter the IP address of the interface present in the transit namespace that is connected to namespace1
	 : give the IP --eg: 110.0.2.1
7: repeat the steps 1-6 for the second namespace(the namespace which has the interface of the other end of tunnel)

8: enter the subnet ID of the VM's
	 : --eg 120.0.0.0/24 

This creates the tunnel between the two VM's connecting to the namespaces which the user defines.
The user can verify this by pinging the VM's from each other and capture the packets at the interfaces
 --eg: the packets captured at the interfaces in the transit namespace will have the vxlan header in it.

##---------The script vxlandelete.sh deletes the vxlan tunnel

If there is a vxlan tunnel created before which needs to be deleted or the vxlan tunnel created by the running the script vxlancreate.sh can be deleted by running vxlandelete.sh
To run the script 
use command: chmod 755 vxlandelete.sh #to give permission to execute
           : ./vxlandelete.sh         #to execute the script

When the command is run it asks for the user inputs

1. enter the name of the first namespace
	 : give the name of the namespace in which the user wishes to delete an existing tunnel --eg:ns1
2. enter the name of the second namespace
	 : give the name of the namespace which has the other end of the tunnel which the user wishes to delete

This deletes the tunnel between the two VM's and it can be verified by pinging one VM from the other...

delete the routes to run the vxlancreate.sh again






