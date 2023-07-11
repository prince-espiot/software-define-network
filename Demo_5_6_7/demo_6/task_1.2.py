import requests
import json
from requests.auth import HTTPBasicAuth

ONOS_REST_URL="http://localhost:8181/onos/v1/"
auth_cred=HTTPBasicAuth('onos', 'rocks')
APP_LINK="org.onosproject."

flow_rule_string = '''{
    "priority": 55000,
    "isPermanent": true,
    "selector": {
        "criteria": [
            {
                "type": "ETH_TYPE",
                "ethType": "0x0800"
            },
            {
                "type": "IP_PROTO",
                "protocol": 1
            },
            {
                "type": "IPV4_DST",
                "ip": "10.0.0.2/32"
            },
            {
                "type": "IPV4_SRC",
                "ip": "10.0.0.3/32"
            },
            {
                "type": "ICMPV4_TYPE",
                "icmpType": "8"
            },
            {
                "type": "ICMPV4_CODE",
                "icmpCode": 0
            }
        ]
    }
}'''


# get the device id by host IP address
def find_device_id_host_by_ip(host_ip):
    device = None
    res_1 = requests.get(ONOS_REST_URL+"hosts", auth=auth_cred)
    if res_1.status_code == 200:
        hosts = res_1.json()['hosts']
        for host in hosts:
            if (host["ipAddresses"][0] == host_ip):
                res_2 = requests.get(
                    ONOS_REST_URL+"devices/"+ host["locations"][0]["elementId"],
                    auth=auth_cred)
                device = res_2.json()
    return device


# Add Flow Rule
def add_flow_rule(device_id, flow_rule_str):
    flow_rule_data = json.loads(flow_rule_str)
    response = requests.post(ONOS_REST_URL+"flows/"+device_id, data=json.dumps(flow_rule_data), auth=auth_cred)
    if response.status_code == 201:
        print("New flow rule added")

# Task 1.2
# Create a flow rule to block the ICMP traffic
# from the “Blue" namespace to the “Red" namespace.
if __name__ == "__main__":
    # Using the Blue namespace IP, find the device
    # it is connected to.
    device = find_device_id_host_by_ip("10.0.0.3")

    # Then add flow rule the device(br-3)
    add_flow_rule(device["id"], flow_rule_string)