#!/usr/bin/python3

import json
import urllib.request


with urllib.request.urlopen('https://hugovk.github.io/top-pypi-packages/top-pypi-packages-30-days.min.json') as response:
    data = json.loads(response.read().decode('utf-8'))
    i = 0
 
    for p in data['rows']:
        if (i > 1000):
            break
        with urllib.request.urlopen(f'https://pypi.org/pypi/{p["project"]}/json') as package_response:
            package = json.loads(package_response.read().decode('utf-8'))
            for url in package['urls']:
                if url['url'].endswith('tar.gz'):
                    print(url['url'])
                    i += 1

