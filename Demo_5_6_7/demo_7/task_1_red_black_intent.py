import requests
from requests.auth import HTTPBasicAuth
import json

url = "http://localhost:8181/onos/v1"
# intent for br-1 red
intent_br1_json = [{
    "type": "PointToPointIntent",
    "appId": "org.onosproject.ovsdb",
    "priority": 100,
    "ingressPoint": {"device": "of:0000e6f52d040545",
                     "port": "4"},
    "egressPoint": {"device": "of:0000e6f52d040545",
                    "port": "1"}},
    {"type": "PointToPointIntent",
     "appId": "org.onosproject.ovsdb",
     "priority": 100,
     "ingressPoint": {"device": "of:0000e6f52d040545",
                      "port": "1"},
     "egressPoint": {"device": "of:0000e6f52d040545",
                     "port": "4"}}
]

# intent for br-2 middle
intent_json = [
    {"type": "PointToPointIntent",
     "appId": "org.onosproject.ovsdb",
     "priority": 100,
     "ingressPoint": {"device": "of:00002ef7388cb14c",
                      "port": "1"},
     "egressPoint": {"device": "of:00002ef7388cb14c",
                     "port": "2"}},
    {
        "type": "PointToPointIntent",
        "appId": "org.onosproject.ovsdb",
        "priority": 100,
        "ingressPoint": {"device": "of:00002ef7388cb14c",
                         "port": "2"},
        "egressPoint": {"device": "of:00002ef7388cb14c",
                        "port": "1"}}
]

# intent for br-6 black
intent_br6_json = [{
    "type": "PointToPointIntent",
    "appId": "org.onosproject.ovsdb",
    "priority": 100,
    "ingressPoint": {"device": "of:000076e55738e942",
                     "port": "2"},
    "egressPoint": {"device": "of:000076e55738e942",
                    "port": "4"}},
    {
        "type": "PointToPointIntent",
        "appId": "org.onosproject.ovsdb",
        "priority": 100,
        "ingressPoint": {"device": "of:000076e55738e942",
                         "port": "4"},
        "egressPoint": {"device": "of:000076e55738e942",
                        "port": "2"}}
]

for i in intent_br1_json:
    myRespon = requests.post(url + '/intents', json=i, auth=HTTPBasicAuth('onos', 'rocks'))
    print("Pass!:", myRespon)
    if myRespon.status_code == requests.codes.ok:
        print("Pass!:", myRespon)

for i in intent_json:
    myRespon = requests.post(url + '/intents', json=i, auth=HTTPBasicAuth('onos', 'rocks'))
    print("Pass!:", myRespon)
    if myRespon.status_code == requests.codes.ok:
        print("Pass!:", myRespon)

for i in intent_br6_json:
    myRespon = requests.post(url + '/intents', json=i, auth=HTTPBasicAuth('onos', 'rocks'))
    print("Pass!:", myRespon)
    if myRespon.status_code == requests.codes.ok:
        print("Pass!:", myRespon)
