import requests
from requests.auth import HTTPBasicAuth
import json
from collections import defaultdict


def extract_fullnames_as_string(list_of_dictionaries):
    return list(map(lambda e: '{}:{}'.format(e['id'], e['annotations']), list_of_dictionaries))

temp = {}
anno_lists = []
anno_dict={}
test_dict = [{'id': 'of:00007acb9e61a943', 'type': 'SWITCH', 'available': False, 'role': 'MASTER',
              'mfr': 'Nicira, Inc.', 'hw': 'Open vSwitch', 'sw': '2.13.5', 'serial': 'None', 'driver': 'ovs',
              'chassisId': '7acb9e61a943', 'lastUpdate': '1648199445651', 'humanReadableLastUpdate':
                  'disconnected 6h30m ago',
              'annotations': {'channelId': '172.17.0.1:49306', 'datapathDescription': 'None',
                              'managementAddress': '172.17.0.1', 'protocol': 'OF_13'}},
             {'id': 'of:00003eb64494da42', 'type': 'SWITCH', 'available': True, 'role': 'MASTER', 'mfr': 'Nicira, Inc.',
              'hw': 'Open vSwitch', 'sw': '2.13.5', 'serial': 'None', 'driver': 'ovs', 'chassisId': '3eb64494da42',
              'lastUpdate': '1648200155633', 'humanReadableLastUpdate': 'connected 6h18m ago',
              'annotations': {'channelId': '172.17.0.1:49868', 'datapathDescription': 'None',
                              'managementAddress': '172.17.0.1', 'protocol': 'OF_14'}}
             ]

# print(type(test_dict))
collect = defaultdict(dict)
#
for key in test_dict:
    collect[key['id']] = key['annotations']
#
temp = dict(collect)
#print(temp)
#
# dic = defaultdict(dict)
dic = extract_fullnames_as_string(test_dict)
# print(dict(dic))
finder = 'of:00007acb9e61a943'
for key,value in temp.items():
    if key == finder:
        print(value)
        anno_dict = value
print(type(anno_dict))

for key in list(anno_dict):
    if key == 'managementAddress':
        print(anno_dict[key])
    if key == 'protocol':
        print(anno_dict[key])


