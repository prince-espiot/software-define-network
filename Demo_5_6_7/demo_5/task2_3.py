import requests
from requests.auth import HTTPBasicAuth
import json
from collections import defaultdict

url = "http://localhost:8181/onos/v1/devices/"

lists = []
temp = {}
id_lists = []
anno_dict = {}
port_list = []
mac_list = []
port_name =[]
collect = defaultdict(dict)
myResponse = requests.get(url, auth=HTTPBasicAuth('onos', 'rocks'))

if myResponse.status_code == requests.codes.ok:
    json_response = json.loads(myResponse.text)
    # print(type(json_response['devices']))
    # print(json_response)
    ids = json_response['devices']
    # print(type(ids[0]))
    for key in ids:
        # print(key)
        lists.append(key)
    # print(type(lists))
    print("List of available device:")
    for id in lists:
        if id['available']:
            print('device ID', id['id'])
    finder = input('Enter the ID: ')
    # print(finder)
    # id_lists.append(id['id'])
    # print(id_lists)

    myResponse = requests.get(url + finder + "/ports", auth=HTTPBasicAuth('onos', 'rocks'))
    if myResponse.status_code == 200:
        json_response = json.loads(myResponse.text)
        # print(json_response)
        anno_dict = json_response['ports']
        port_list.append(anno_dict)
        for id in anno_dict:
            anno_dict = (id['annotations'])

            for key in list(anno_dict):
                if key == 'portMac':
                    mac_list.append(anno_dict[key])
                    # print('MAC addresses: ', anno_dict[key])

                if key == 'portName':
                    port_name.append(anno_dict[key])
                    # print('portName: ', anno_dict[key])
        print('MAC addresses: ')
        for i in mac_list:
            print(i)

        print('\nportName: ')
        for i in port_name:
            print(i)