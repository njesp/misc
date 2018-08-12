
import json
import requests
ip = json.loads(requests.get('https://api.ipify.org?format=json').text)['ip']
print(ip)
