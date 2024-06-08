#!/usr/bin/python3
"""
Module to get the number of subscribers in a given subreddit
"""
import requests
from typing import Union

def number_of_subscribers(subreddit: str) -> Union[int, None]:
    """
    Queries the Reddit API to find the number of subscribers for a given subreddit.

    Args:
        subreddit (str): The name of the subreddit.

    Returns:
        int: Number of subscribers if the request was successful.
        None: If there was an error in the request.
    """
    url = f"https://www.reddit.com/r/{subreddit}/about.json"
    headers = {'User-Agent': 'Mozilla/5.0'}
    try:
        response = requests.get(url, headers=headers, allow_redirects=False)
        if response.status_code != 200:
            return 0
        data = response.json()
        return data.get('data', {}).get('subscribers', 0)
    except requests.RequestException as e:
        print(f"Request failed: {e}")
        return None
    except ValueError:
        print("Failed to parse JSON response.")
        return None

# Example usage:
# print(number_of_subscribers("python"))
