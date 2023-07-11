import requests
from requests.auth import HTTPBasicAuth
import json
from collections import defaultdict

url = "http://localhost:8181/onos/v1/"

lists = []
temp = {}
flows_lists = []
anno_dict = {}
port_list = []
mac_list = []
port_name = []
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

    finder = input('Enter the ID: ')
    myResponse = requests.get(url + 'flows/' + finder, auth=HTTPBasicAuth('onos', 'rocks'))
    if myResponse.status_code == 200:
        json_response = json.loads(myResponse.text)
        # print(json_response)
        idss = json_response["flows"]
        for key in idss:
            # print(key)
            flows_lists.append(key)
        # print(flows_lists)
        print("List of available flow rules for :\n")
        print(
            '-----------------------------------------------------------------------------------------------------------')
        print('FLOW RULES FOR ', finder,)
        print(
            '-----------------------------------------------------------------------------------------------------------')
        for item in flows_lists:
            print(item, '\n')
