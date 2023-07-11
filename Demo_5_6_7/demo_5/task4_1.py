import requests
from requests.auth import HTTPBasicAuth
import json
from collections import defaultdict

url = "http://localhost:8181/onos/v1/links"

lists = []
temp = {}
id_lists = []
anno_dict = {}
port_list = []
mac_list = []
port_name = []
collect = defaultdict(dict)

myResponse = requests.get(url, auth=HTTPBasicAuth('onos', 'rocks'))

if myResponse.status_code == requests.codes.ok:
    json_response = json.loads(myResponse.text)
    # print(type(json_response['links']))
    # print(json_response)
    ids = json_response['links']
    # print(type(ids[0]))
    for key in ids:
        # print(key)
        lists.append(key)
    print(lists)
    print("Table of available Links:\n")
    print('-------------------------------------------------------------------------------------')
    print('device id source  \tport sources \tdevice id destination \t port destination.  |')
    print('-------------------------------------------------------------------------------------')
    for id in lists:
        if id['state'] == "ACTIVE":
            print(id['src']['device'], '\t', id['src']['port'], '\t', id['dst']['device'], '\t', id['dst']['port'])
