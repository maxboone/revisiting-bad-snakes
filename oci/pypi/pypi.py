#!/usr/local/bin/python3

import argparse
from yara_scanner import YaraScanner
import os
import json
from pathlib import Path
from typing import Dict


# Scanning packages using PyPI
# returns a dict with for each .py filepath as key the rules a list of broken for that key
def scanning_packages(package_path, scanner: YaraScanner) -> Dict:
    results = {}
    for subdir, _, files in os.walk(package_path):
        for file in files:
            file_path = subdir + os.sep + file
            # Only scan Python files to reduce noises, there are packages that don't have Python files at all
            if Path(file_path).suffix == '.py':
                results[file_path] = []
                try:
                    scanner.scan(file_path)
                except Exception as _:
                    pass
                else:
                    scan_results = scanner.scan_results
                    if scan_results:
                        for result in scan_results:
                            # Probably useful to not cast to str here but actually preparse
                            results[file_path].append(str(result))
    return results

def get_yara_scanner() -> YaraScanner:
    pypi_malware_checks_rule_path = os.path.abspath("/app/rules.yara")
    scanner = YaraScanner()
    scanner.track_yara_file(pypi_malware_checks_rule_path)
    scanner.load_rules()

    return scanner

if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog='pypi-scanner')
    parser.add_argument('package_dir_path', type=str)
    args = parser.parse_args()

    scanner = get_yara_scanner()
    result = scanning_packages(args.package_dir_path, scanner)
    result_as_string = json.dumps(result)

    print(result_as_string)


