#!/usr/bin/env bash 
   
number_of_bridges=10 
 
ip -all netns delete 

 
# Remove Bridges 

for ((i=0; i<=$number_of_bridges; i++)) 
do 
   ovs-vsctl del-br br-$i 
   for ((j=0; j<=$number_of_bridges; j++)) 
   do
   	ovs-vsctl del-br br-$i.$j 
 
   done
    
done

 
 
# Remove links 
for name in $(ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d' | grep int)
do
    echo $name
    # ip link delete $name # uncomment this
done

for name in $(ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d' | grep br)
do
    echo $name
    ip link delete $name # uncomment this
done

for name in $(ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d' | grep veth-)
do
    echo $name
    # ip link delete $name # uncomment this
done


