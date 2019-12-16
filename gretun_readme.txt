Configure the topology as per the question

-- created a bridge to connect the VM's to the namespaces
-- used veth pairs for the links
-- place the veth pairs in the same subnet 
-- configure the routes in the VM's 
 	-- a route to the VM belonging to a different subnet
	-- a route to the namespace 1
-- don't have to configure any additional routes in the namespaces 
-- place the VM's in different subnets


##-------The script gretuncreate.sh creates the gre tunnel

To run the script 
use command: chmod 755 gretuncreate.sh   #to give permission to execute
           : ./gretuncreate.sh         #to execute the script

When the command is run it asks for the user inputs

1. enter the name of the first namespace
	 : give the name of the namespace in which the user wishes to create the tunnel --eg:ns1,ns3,NAMESPACE2.....etc;
2. enter the name of the second namespace
	 : give the name of the namespace in which the user wishes to create the end point of this tunnel --eg:ns1,ns2,namespace3...etc;
3. enter the IP address of the local interface for the tunnel in first namespace
	 : give the IP address of the interface  --eg:110.0.2.1
4: enter the IP address of the remote interface for the tunnel in second namespace
	 : give the IP address of the interface  --eg:110.0.3.2
5: enter the name of the interface in the namespace 1 connected to the VM
	 : give the name of the interface which is present in the first namespace and which is connected to the VM --eg:veth1
6 enter the name of the interface in the namespace1 connected to the transit namespace
	 : give the name of the interface which is present in the first namespace and which is connected to the transit --eg:ve2
7 enter the IP address of the interface connected to namespace1 which is present in the transit namespace
	 : give the IP address of the interface which is in the transit namespace and connected to the namespace1 --eg:110.0.2.2
8 enter the subnet ID of this interface
	 : give the subnet ID for the above interface --eg:110.0.2.0/24
9 enter the subnet ID of the first VM
	 : give the subnet ID of the VM connected to first namespace


10: repeat the steps 5 to 9 for the second namespace(the namespace which has the interface of the other end of tunnel)

This creates the tunnel between the two VM's connecting to the namespaces which the user defines.
The user can verify this by pinging the VM's from each other and capture the packets at the interfaces
 --eg: the packets captured at the interfaces in the transit namespace will have the gre field in its header.

##---------The script gretundelete.sh deletes the gre tunnel

If there is a gre tunnel created before which needs to be deleted or the gre tunnel created by the running the script gretuncreate.sh can be deleted by running gretundelete.sh
To run the script 
use command: chmod 755 gretundelete.sh #to be executed only the first time to give permission to execute the script
           : ./gretundelete.sh         #to execute the script

When the command is run it asks for the user inputs

1. enter the name of the first namespace
	 : give the name of the namespace in which the user wishes to delete an existing tunnel --eg:ns1
2. enter the name of the second namespace
	 : give the name of the namespace which has the other end of the tunnel which the user wishes to delete

This deletes the tunnel between the two VM's and it can be verified by pinging one VM from the other...

delete the routes to run the gretuncreate.sh again




