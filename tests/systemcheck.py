#!/usr/bin/python
import requests

servers = {}
for i in range(0, 9):
    re = requests.get("http://localhost/", timeout=1)
    if re.status_code == 200:
        servers[re.text] = "1"
print str(len(servers)) + " servers in service"
