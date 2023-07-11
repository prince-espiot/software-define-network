import requests
from requests.auth import HTTPBasicAuth
import json
from collections import defaultdict

url = "http://localhost:8181/onos/v1/"

lists = []

flows_lists = []
anno_dict = {}
port_list = []

collect = defaultdict(dict)

myResponse = requests.get(url + 'devices', auth=HTTPBasicAuth('onos', 'rocks'))

if myResponse.status_code == requests.codes.ok:
    json_response = json.loads(myResponse.text)
    # print(type(json_response['devices']))
    # print(json_response)
    ids = json_response['devices']
    # print(type(ids[0]))
    for key in ids:
        # print(key)
        lists.append(key)
    # print(lists)
    print("List of available devices:\n")
    print('------------------------')
    print('DEVICES ID ')
    print('------------------------')
    for id in lists:

        if id['available']:
            print(id['id'])

    finder = input('Enter the Device ID: ')
    myResponse = requests.get(url + 'flows/' + finder, auth=HTTPBasicAuth('onos', 'rocks'))
    if myResponse.status_code == 200:
        json_response = json.loads(myResponse.text)
        # print(json_response)
        idss = json_response["flows"]
        for key in idss:
            # print(key)
            flows_lists.append(key)
        # print(flows_lists)
        print("List of available Flow IDs:\n")
        print('------------------------')
        print('FLOW ID ')
        print('------------------------')
        for item in flows_lists:
            print(item['id'])

        flow_id = input('Enter the flow ID: ')
        myResponse = requests.delete(url + 'flows/' + finder + '/' + flow_id, auth=HTTPBasicAuth('onos', 'rocks'))
        print('Deleted!:', myResponse)
