#!/usr/bin/python3

import json
import urllib.request

api_key = input("Please provide your libraries.io API_KEY: ")

for i in range(0, 10):
    # Send a GET request using urllib.request
    with urllib.request.urlopen(f'https://libraries.io/api/search?order=desc&platforms=PyPI&sort=dependents_count&page={i + 1}&per_page=100&api_key={api_key}') as response:
        # Load JSON data from the response
        data = json.loads(response.read().decode('utf-8'))

        for p in data:
            # Send a GET request to pypi.org using urllib.request
            with urllib.request.urlopen(f'https://pypi.org/pypi/{p["name"]}/json') as package_response:
                # Load JSON data from the package response
                package = json.loads(package_response.read().decode('utf-8'))

                for url in package['urls']:
                    if url["url"].endswith("tar.gz"):
                        print(url["url"])
                        
