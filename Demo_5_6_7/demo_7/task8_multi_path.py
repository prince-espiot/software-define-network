import requests
from requests.auth import HTTPBasicAuth
import json
from collections import defaultdict

url = "http://localhost:8181/onos/v1"

lists = []
ns_lists = []
anno_dict = {}
red = 0
black = 0
blue = 0
green = 0
yellow = 0
collect = defaultdict(dict)

myResponse = requests.get(url + '/hosts', auth=HTTPBasicAuth('onos', 'rocks'))

if myResponse.status_code == requests.codes.ok:
    json_response = json.loads(myResponse.text)
    # print(type(json_response['hosts']))
    # print(json_response)
    ids = json_response['hosts']
    # print(type(ids[0]))
    for key in ids:
        # print(key)
        lists.append(key)
    # print(type(lists))
    print("List of available hosts:\n")
    for id in lists:
        print(id['id'], '\t', id['mac'], '\t', id['ipAddresses'][0])

    for id in lists:
        if id['ipAddresses'][0] == '10.0.0.2':
            red = id['id']
            myResponse = requests.get(url + '/hosts/' + red, auth=HTTPBasicAuth('onos', 'rocks'))
            if myResponse.status_code == 200:
                json_response = json.loads(myResponse.text)
                # print(json_response)
                anno_dict = json_response['locations']
                # print(anno_dict)
                red = anno_dict[0]['elementId']

        if id['ipAddresses'][0] == '10.0.0.5':
            black = id['id']
            myResponse = requests.get(url + '/hosts/' + black, auth=HTTPBasicAuth('onos', 'rocks'))
            if myResponse.status_code == 200:
                json_response = json.loads(myResponse.text)
                # print(json_response)
                anno_dict = json_response['locations']
                # print(anno_dict)
                black = anno_dict[0]['elementId']

        if id['ipAddresses'][0] == '10.0.0.3':
            blue = id['id']
            myResponse = requests.get(url + '/hosts/' + blue, auth=HTTPBasicAuth('onos', 'rocks'))
            if myResponse.status_code == 200:
                json_response = json.loads(myResponse.text)
                # print(json_response)
                anno_dict = json_response['locations']
                # print(anno_dict)
                blue = anno_dict[0]['elementId']

        if id['ipAddresses'][0] == '10.0.0.4':
            green = id['id']
            myResponse = requests.get(url + '/hosts/' + green, auth=HTTPBasicAuth('onos', 'rocks'))
            if myResponse.status_code == 200:
                json_response = json.loads(myResponse.text)
                # print(json_response)
                anno_dict = json_response['locations']
                # print(anno_dict)
                green = anno_dict[0]['elementId']

ns_lists = [red, blue, green, black]

print(ns_lists)
intent_json = {
    "type": "SinglePointToMultiPointIntent",
    "appId": "org.onosproject.ovsdb",
    "priority": 57000,
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
                "type": "TCP_SRC",
                "tcpPort": 4009
            },
            {
                "type": "TCP_DST",
                "tcpPort": 4009
            },

        ]
    },
    "ingressPoint": {"device": red,
                     "port": "4"},
    "egressPoint": [{"device": blue,
                     "port": "3"}, {"device": green,
                                    "port": "2"}, {"device": black,
                                                   "port": "4"}]}

myRespon = requests.post(url + '/intents', json=intent_json, auth=HTTPBasicAuth('onos', 'rocks'))
print("Pass!:", myRespon)
if myRespon.status_code == requests.codes.ok:
    print("Pass!:", myRespon)
