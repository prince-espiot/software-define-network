import requests
from requests.auth import HTTPBasicAuth
import json
from collections import defaultdict

url = "http://localhost:8181/onos/v1/hosts/"

lists = []
anno_dict = {}

collect = defaultdict(dict)

myResponse = requests.get(url, auth=HTTPBasicAuth('onos', 'rocks'))

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
        i = 0
        print(id['id'], '\t', id['mac'], '\t', id['ipAddresses'][i])
        i = i + 1

    finder = input('Enter the ID: ')

    for id in lists:
        i = 0
        if id['ipAddresses'][i] == finder:
            addon = id['id']
        i=i+1

    myResponse = requests.get(url + addon , auth=HTTPBasicAuth('onos', 'rocks'))
    if myResponse.status_code == 200:
        json_response = json.loads(myResponse.text)
        # print(json_response)
        anno_dict = json_response['locations']
        # print(anno_dict)
        print('Device ID: ', anno_dict[0]['elementId'])
        print('Port Number: ', anno_dict[0]['port'])