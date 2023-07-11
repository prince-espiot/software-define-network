#!/usr/bin/env bash

# creates the host
function create_ns() {
echo "Creating the namespace $1"
ip netns add $1
}

# creates the switch
function create_ovs_bridge() {
echo "Creating the OVS bridge $1"
ovs-vsctl set bridge $1 protocol=OpenFlow13
ovs-vsctl add-br $1

}

# attach host to switch
function attach_ns_to_ovs() {
echo "Attaching the namespace $1 to the OVS $2"
ip link add $3 type veth peer name $4
ip link set $3 netns $1
ovs-vsctl add-port $2 $4 -- set Interface $4 ofport_request=$5
ip netns exec $1 ip addr add $6/24 dev $3
ip netns exec $1 ip link set dev $3 up
ip link set $4 up
}

# attach switch to switch
function attach_ovs_to_ovs() {
echo "Attaching the OVS $1 to the OVS $2"
ip link add name $3 type veth peer name $4
ip link set $3 up
ip link set $4 up
ovs-vsctl add-port $1 $3 -- set Interface $3 ofport_request=$5
ovs-vsctl add-port $2 $4 -- set Interface $4 ofport_request=$5
}

# attach switch to remote controller
function attach_ovs_to_sdn() {
echo "Attaching the OVS bridge to the ONOS controller"
ovs-vsctl set-controller $1 tcp:127.0.0.1:6653
}

function linear_topology(){

num_of_ns=$1
#creating namespace
for((i=1; i<=$num_of_ns; i++))
do
   create_ns h$i
done
# create_ns h1
# create_ns h2
# create_ns h3
# create_ns h4
# create_ns h5


# create_ovs_bridge 
for((i=1; i<=$num_of_ns; i++))
do
   create_ovs_bridge br-$i
done
# create_ovs_bridge br-1
# create_ovs_bridge br-2
# create_ovs_bridge br-3
# create_ovs_bridge br-4
# create_ovs_bridge br-5

# attach bridge to bridge
for((i=1; i<=$num_of_ns; i++))
do
    j=$((i+1))
    attach_ovs_to_ovs br-$i br-$j br-ovs$i br-ovs$i-$j 1
done

# attach namespace to brigdes
for ((i=1; i<=$num_of_ns; i++))
do
   j=$((i+1))
   attach_ns_to_ovs h$i br-$i veth-br-$i veth-br-ovs$i 2 10.0.0.$j
done

# attach_ns_to_ovs h1 br-1 veth-br-1 veth-br-ovs1 2 10.0.0.2
# attach_ns_to_ovs h2 br-2 veth-br-2 veth-br-ovs2 2 10.0.0.3
# attach_ns_to_ovs h3 br-3 veth-br-3 veth-br-ovs3 2 10.0.0.4
# attach_ns_to_ovs h4 br-4 veth-br-4 veth-br-ovs4 2 10.0.0.5
# attach_ns_to_ovs h5 br-5 veth-br-5 veth-br-ovs5 2 10.0.0.6



# attach brigdes to snd controller
for ((i=1; i<=$num_of_ns; i++))
do
   attach_ovs_to_sdn br-$i
done

# attach_ovs_to_sdn br-1
# attach_ovs_to_sdn br-2
# attach_ovs_to_sdn br-3
# attach_ovs_to_sdn br-4
# attach_ovs_to_sdn br-5

#pingall
# Ping hosts
hin=$num_of_ns
for ((i=1; i<=$num_of_ns; i++))
do
    j=$((i+1))
    ip netns exec h$hin ping -c 1 10.0.0.$j
done


}

function tree_topology(){
depth=$1
fanout=$2
mod=0

for ((i=0; i<= depth; i++))
do	

  bin=1 #brigde index
  host=1 # used  to keep track of the hosts # create first bridge as first branch which other branches connect
  for ((j=1; j<=$(($2**$i)); j++))
  do
	if(($i == depth)) # proceed into the statement only if i is equal to the depth, intended to create host to 			  #respective bridge
	then
	    # p=$(($h+1)) 
	    # b=$(($i - 1)) # intented to make connection to pervious brigde in the next two lines
	    create_ns h-$host # create hosts as and when needed further down the line
	    attach_ns_to_ovs h-$host br-$(($i - 1)).$bin veth-br-$host veth-br-ovs$host-$(($h + 1))  2 10.0.0.$host
	    host=$(($host+1))
	else #if i is not equal to the depth, means create more brigdes and 
	    create_ovs_bridge br-$i.$j 
	    attach_ovs_to_ovs br-$(($i - 1)).$bin br-$i.$j br-ovs$mod br-ovs$mod-$(($mod + 1)) 1
	    attach_ovs_to_sdn br-$i.$j
	    mod=$(($mod+1))
	fi
	if(($j % $2==0))
	then
	    bin=$(($bin + 1))
	fi
   done
done


# Ping hosts
hin=$(($1**$2))
for ((i=1, j=$(($hin - 1)); i<$hin; i++, j--))
do
    ip netns exec h-$i ping -c 1 10.0.0.$j
done


}

VAR1="linear"
VAR2="tree"

read -r -p"Enter the topo you want: " reply
echo "$reply" 
if [[ "$reply" == "$VAR1" ]]; then
   echo "Creating Linear topo"
   read -r -p"How many Linear topology you want: " lin
   linear_topology $lin
elif [[ "$reply" == "$VAR2" ]]; then
    echo "Creating Tree topo"
    read -r -p"How many depths you want: " depth
    read -r -p"How many fanout you want: " fanout
    tree_topology $depth $fanout
else 
    echo "incorrect arguments"
fi

