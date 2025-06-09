#!/usr/bin/env python3

import requests, json, sys, logging

logging.basicConfig(level=logging.INFO, format='%(levelname)s: %(message)s')

def get_posts():
    if len(sys.argv) < 2:
        logging.error("Usage: python script.py <url>")
        sys.exit(1)
        
    url = sys.argv[1]

    try:
        response = requests.get(url)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        logging.error("Error fetching data: %s", e)
        return None
    
def order_by_name(universities):
    try:
        sorted_data = sorted(universities, key=lambda x: x['name'].lower())
    except KeyError:
        logging.error("Error: Missing 'name' field in one or more items")
        return None

    return sorted_data
    
def main():
    universities = get_posts()
    if universities:
        sorted_universities = order_by_name(universities)
        if sorted_universities:
            logging.info("Successfully sorted universities:")
            print(json.dumps(sorted_universities, indent=2))
        else:
            logging.error("Sorting failed due to missing fields.")
    else:
        logging.error("Failed to fetch universities from the API.")

if __name__ == "__main__":
    main()