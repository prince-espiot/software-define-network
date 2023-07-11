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
port_name = []
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
    print('HOSTS \t\t\t IP management address \t\t Protocol |')
    for id in lists:
        if id['available']:
            print(id['id'], '\t', id['annotations']['managementAddress'], '\t', id['annotations']['protocol'])