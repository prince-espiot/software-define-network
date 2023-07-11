import requests
from requests.auth import HTTPBasicAuth
import json

url = "http://localhost:8181/onos/v1/intents"

lists = []

myResponse = requests.get(url, auth=HTTPBasicAuth('onos', 'rocks'))

if myResponse.status_code == requests.codes.ok:
    json_response = json.loads(myResponse.text)
    # print(type(json_response['intents']))
    # print(json_response['intents'])
    ids = json_response["intents"]
    for key in ids:
        # print(key)
        lists.append(key)
    print(lists)
    print("Table of Intents:\n")
    print('-------------------------------------------------------------------------------------')
    print('Intent id   \tState \tType \t Application ID  |')
    print('-------------------------------------------------------------------------------------')
    for id in lists:
            print(id['id'], '\t', id['state'], '\t', id['type'], '\t', id['appId'])