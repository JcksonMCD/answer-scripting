#!/usr/bin/env python3 

import requests

def get_posts():
    url = "http://universities.hipolabs.com/search?country=United+Kingdom"

    try:
        response = requests.get(url)

        if response.status_code == 200:
            posts = response.json()
            return posts
        else:
            print ('Error: ', response.status_code)
            return None
    except requests.exceptions.RequestException as e:
        print('Error: ', e)
        return None