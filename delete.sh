#!/usr/bin/env bash 
   
number_of_bridges=5 
 
ip -all netns delete 
 
# Remove Bridges 
for i in $(ovs-vsctl list-br))
do 
    ovs-vsctl del-br $i 
done 
 
# Remove links 
for ((i=1; i<=$10; i++)) 
do 
   ip link delete br-ovs$i 
   for ((j=1; j<=$10; j++)) 
   do
   	ip link delete br-ovs$i-$j
   	ip link delete vert-br-ovs$i-$j
   done
    
done


# remove lxc containers 

for i in $(lxc-ls -1); do
     lxc-stop -n $i
     lxc-destroy -n $i
done
