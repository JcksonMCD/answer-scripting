#!/usr/bin/env python3 

import requests
import json

def get_posts():
    url = "http://universities.hipolabs.com/search?country=United+Kingdom"

    try:
        response = requests.get(url)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print("Error fetching data:", e)
        return None
    
def order_by_name(universities):
    try:
        sorted_data = sorted(universities, key=lambda x: x['name'].lower())
    except KeyError:
        return print("Error: Missing 'name' field in one or more items")

    return sorted_data
    
def main():
    universities = get_posts()
    if universities:
        sorted_universities = order_by_name(universities)
        print(json.dumps(sorted_universities, indent=2))
    else:
        print("Failed to fetch universities from the API.")

if __name__ == "__main__":
    main()