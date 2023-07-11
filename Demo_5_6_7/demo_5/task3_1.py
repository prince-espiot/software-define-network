import requests
from requests.auth import HTTPBasicAuth
import json
from collections import defaultdict

url = "http://localhost:8181/onos/v1/hosts/"

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
    # print(type(json_response['hosts']))
    # print(json_response)
    ids = json_response['hosts']
    # print(type(ids[0]))
    for key in ids:
        # print(key)
        lists.append(key)
    # print(type(lists))
    print("List of available hosts:\n")
    print('------------------------------------------------------------')
    print('HOSTS \t\t\t MAC address \t\t IP address |')
    print('------------------------------------------------------------')
    for id in lists:
        i = 0
        print(id['id'], '\t', id['mac'], '\t', id['ipAddresses'][i])
        i = i + 1

