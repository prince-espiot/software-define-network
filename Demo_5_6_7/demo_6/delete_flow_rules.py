import requests
from requests.auth import HTTPBasicAuth
import json

url = "http://localhost:8181/onos/v1/flows"

myResponse = requests.delete(url,  auth=HTTPBasicAuth('onos', 'rocks'))
if myResponse.status_code == requests.codes.ok:
    print("Pass!")