import requests
from requests.auth import HTTPBasicAuth
import json
from collections import defaultdict

url = "http://localhost:8181/onos/v1/devices/"

lists = []
temp = {}
anno_lists = []
anno_dict = {}
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

    for key in ids:
        collect[key['id']] = key['annotations']
    #
    temp = dict(collect)
    for key, value in temp.items():
        if key == finder:
            # print(value)
            anno_dict = value
    # print(type(anno_dict))

    for key in list(anno_dict):
        if key == 'managementAddress':
            print('IP managementAddress: ', anno_dict[key])
        if key == 'protocol':
            print('OF protocol: ', anno_dict[key])


