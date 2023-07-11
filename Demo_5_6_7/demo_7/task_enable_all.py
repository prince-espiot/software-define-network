import requests
from requests.auth import HTTPBasicAuth
import json

url = "http://localhost:8181/onos/v1"
lists = []
ns_lists = []
red = 0
black = 0
blue = 0
green = 0
yellow = 0
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

    for id in lists:
        if id['ipAddresses'][0] == '10.0.0.5':
            black = id['id']

    for id in lists:
        if id['ipAddresses'][0] == '10.0.0.3':
            blue = id['id']

    for id in lists:
        if id['ipAddresses'][0] == '10.0.0.4':
            green = id['id']

    for id in lists:
        if id['ipAddresses'][0] == '10.0.0.6':
            yellow = id['id']

ns_lists = [red, blue, black, yellow, green]

for i in ns_lists:
    for j in reversed(ns_lists):
        if i != j:
            intent_json = {
                "type": "HostToHostIntent",
                "appId": "org.onosproject.ovsdb",
                "priority": 55000,
                "one": i,
                "two": j
            }

            myRespon = requests.post(url + '/intents', json=intent_json, auth=HTTPBasicAuth('onos', 'rocks'))
            print("Pass!:", myRespon)
            if myRespon.status_code == requests.codes.ok:
                print("Pass!:", myRespon)
