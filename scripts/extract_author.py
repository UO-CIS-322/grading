"""
Extract the 'author = ' line from a credentials file.
File must have fixed name credentials.py, in this directory
"""
import configparser
try:
    config = configparser.ConfigParser()
    config.read('scripts/credentials.conf')
    print(config['DEFAULT']['author'])
except Exception as err: 
    print("***Unable to extract author line***")
