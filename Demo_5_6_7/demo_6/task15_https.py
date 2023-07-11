import requests
from requests.auth import HTTPBasicAuth
import json
from collections import defaultdict

url = "http://localhost:8181/onos/v1"

lists = []
anno_dict = {}

collect = defaultdict(dict)

myResponse = requests.get(url + '/hosts', auth=HTTPBasicAuth('onos', 'rocks'))

if myResponse.status_code == requests.codes.ok:
    json_response = json.loads(myResponse.text)
    ids = json_response['hosts']
    for key in ids:
        lists.append(key)
    print("List of available hosts:\n")
    print('------------------------------------------------------------')
    print('HOSTS \t\t\t MAC address \t\t IP address |')
    print('------------------------------------------------------------')
    for id in lists:
        print(id['id'], '\t', id['mac'], '\t', id['ipAddresses'][0])

    for id in lists:
        if id['ipAddresses'][0] == '10.0.0.2':
            addon = id['id']

    Response = requests.get(url + '/hosts/' + addon, auth=HTTPBasicAuth('onos', 'rocks'))
    if Response.status_code == 200:
        json_response = json.loads(Response.text)
        anno_dict = json_response['locations']
        DeviceID = anno_dict[0]['elementId']
        flow_rule = {
            "flows": [
                {
                    "priority": 65000,
                    "timeout": 0,
                    "isPermanent": True,
                    "deviceId": DeviceID,  # br-1
                    "treatment": {
                        "instructions": [{
                            "type": "OUTPUT",
                            "port": "NORMAL"
                        }
                        ]
                    },
                    "selector": {
                        "criteria": [
                            {
                                "type": "ETH_TYPE",
                                "ethType": "0x0800"
                            },
                            {
                                "type": "IP_PROTO",
                                "protocol": 6
                            },
                            {
                                "type": "IPV4_DST",
                                "ip": "10.0.0.2/32"
                            },
                            {
                                "type": "TCP_DST",
                                "tcpPort": 443
                            },
                        ]
                    }
                }
            ]
        }

        myRespon = requests.post(url + '/flows', json=flow_rule, auth=HTTPBasicAuth('onos', 'rocks'))
        if myRespon.status_code == requests.codes.ok:
            print("Pass!")
