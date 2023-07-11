import requests
from requests.auth import HTTPBasicAuth
import json

url = "http://localhost:8181/onos/v1/devices/"

lists = []

myResponse = requests.get(url, auth=HTTPBasicAuth('onos', 'rocks'))

if myResponse.status_code == requests.codes.ok:
    json_response = json.loads(myResponse.text)
    print(type(json_response['devices']))
    print(json_response)
    ids = json_response['devices']
    print(type(ids[0]))
    for key in ids:
        print(key)
        lists.append(key)
    print(type(lists))

    for id in lists:
        if id['available']:
            print('device ID',id['id'])
