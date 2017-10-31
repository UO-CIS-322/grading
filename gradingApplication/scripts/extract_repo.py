"""
Extract the 'repo = ' line from a credentials file.
File must have fixed name credentials.py, in this directory
"""
import configparser
try:
    config = configparser.ConfigParser()
    config.read('scripts/credentials.conf')
    print(config['DEFAULT']['repo'])
except Exception as err: 
    print("***Unable to extract repo line***")
    sys.exit(1)  # Error code for shell

    
