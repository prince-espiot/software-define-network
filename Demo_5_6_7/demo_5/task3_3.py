import requests
from requests.auth import HTTPBasicAuth
import json
from collections import defaultdict

url = "http://localhost:8181/onos/v1/hosts/B6%3A6A%3A73%3A13%3AF3%3A39/None"

collect = defaultdict(dict)

myResponse = requests.delete(url, auth=HTTPBasicAuth('onos', 'rocks'))
if myResponse.status_code == requests.codes.ok:
    print('deleted')