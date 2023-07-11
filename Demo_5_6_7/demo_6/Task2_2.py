import requests
from requests.auth import HTTPBasicAuth
import json
from collections import defaultdict
import numpy as np

url = "http://localhost:8181/onos/v1/"

lists = []
temp = {}
flows_lists = []
anno_dict = {}
port_list = []
mac_list = []
port_name = []
collect = defaultdict(dict)

myResponse = requests.get(url + 'flows', auth=HTTPBasicAuth('onos', 'rocks'))

if myResponse.status_code == requests.codes.ok:
    json_response = json.loads(myResponse.text)
    # print(type(json_response['flows']))
    # print(json_response)
    ids = json_response['flows']
    # print(type(ids[0]))
    for key in ids:
        # print(key)
        lists.append(key)
    # print(lists)
    print("List of available application id:\n")
    print('------------------------')
    print('application  ID ')
    print('------------------------')
    for id in lists:
        # print(id['appId'])
        port_list.append(id['appId'])
    x = np.array(port_list)
    for i in np.unique(x):
        print(i)
    finder = input('Enter the application ID: ')
    myResponse = requests.get(url + 'flows/application/' + finder, auth=HTTPBasicAuth('onos', 'rocks'))
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
        print('FLOW RULES FOR ', finder, )
        print(
            '-----------------------------------------------------------------------------------------------------------')
        for item in flows_lists:
            print(item, '\n')
