import lxc_driver
import os
import time
import docker
import numpy
import random


def create_ovs(ovs_name):
    print("Creating the OVS bridge {}".format(ovs_name))
    basic_cmd = 'sudo ovs-vsctl add-br {}'.format(ovs_name)
    os.system(basic_cmd)
    basic_cmd = 'sudo ovs-vsctl set bridge {} protocol=OpenFlow13'.format(ovs_name)
    os.system(basic_cmd)


def create_link_ovs(ovs_name_1, ovs_name_2, ovs_interface_1, ovs_interface_2, ovs_port):
    print("Attaching the OVS {} to the OVS {}".format(ovs_name_1, ovs_name_2))

    basic_cmd = 'sudo ip link add name {} type veth peer name {}'.format(ovs_interface_1, ovs_interface_2)
    os.system(basic_cmd)

    basic_cmd = "ip link set {} up".format(ovs_interface_1)
    os.system(basic_cmd)

    basic_cmd = "ip link set {} up".format(ovs_interface_2)
    os.system(basic_cmd)

    basic_cmd = "sudo ovs-vsctl add-port {0} {1} -- set Interface {1} ofport_request={2}" \
        .format(ovs_name_1, ovs_interface_1, ovs_port)
    os.system(basic_cmd)

    basic_cmd = "sudo ovs-vsctl add-port {0} {1} -- set Interface {1} ofport_request={2}" \
        .format(ovs_name_2, ovs_interface_2, ovs_port)
    os.system(basic_cmd)


def attach_ovs_to_sdn(ovs_name):
    print("Attaching the OVS bridge to the ONOS controller")
    client = docker.DockerClient()
    container = client.containers.get("onos")
    ip_add = container.attrs['NetworkSettings']['IPAddress']
    basic_cmd = "ovs-vsctl set-controller {} tcp:{}:6653".format(ovs_name, ip_add)
    os.system(basic_cmd)


def create_lxc_container(container_name, ovs_name, ovs_port, ip_address):
    print("Creating the container: {}".format(container_name))
    if lxc_driver.create_container(container_name):
        lxc_driver.modify_configuration_bridge(container_name)
        lxc_driver.container_bridge_ovs(container_name, ovs_name, ovs_port)
        time.sleep(5)
        if not lxc_driver.start_container(container_name):
            return False
        time.sleep(2)
        lxc_driver.container_attach(container_name, ["ip", "addr", "add", "{}/24".format(ip_address), "dev", "eth0"])
        lxc_driver.container_attach(container_name, ["ip", "link", "set", "dev", "eth0", "up"])
        while len(lxc_driver.get_ip_container(container_name)) != 1:
            time.sleep(1)
        response = 0
        while response != 256:
            response = lxc_driver.container_attach(container_name, ["ping", "-c", "1", "10.0.0.90"])
        return True


if __name__ == '__main__':
    num_spine = 1
    num_of_leave = 2
    number_of_host = 2
	# bottom up approach
	# first create 8 switches and assign two host to each
	
	
    for n in range(num_spine):
		create_ovs(f'ovs-spine{n}') 
		attach_ovs_to_sdn(f'ovs-spine{n}')
		
    for j in range(num_of_leave): 
        create_ovs(f'ovs-leave{j}')
		attach_ovs_to_sdn(f'ovs-leave{j}')
        # loop through the leaves (8 switches)
        for k in range(1,3,1):        
			print(f'ovs-leave{j}',f'cont{k}')
			ip2 = str("10.0.0."+str(j)+str(k+1))
            create_lxc_container(f'cont{k}',f'ovs-leave{j}',j,ip2)
           
        
            
	# now creat the spines and for each spine assign a link from the leaves to each
    
    for j in range(num_spine): 
        # loop through the leaves (8 switches)
        for k in range(num_of_leave): 
			var2 = "veth-" + str(k) +"."+str(j+1)
            int_ = "int-" + str(k)+"." + str(j+1)
            create_link_ovs(f'ovs-spine{j}',f'ovs-leave{k}',int_+var, int_+var2,(k*10*j) )
            

             
          	

