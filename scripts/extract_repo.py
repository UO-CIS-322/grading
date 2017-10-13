"""
Extract the 'repo = ' line from a credentials file.
File must have fixed name credentials.py, in this directory
"""
import configparser
try:
    config = configparser.ConfigParser()
    config.read('credentials.py')
    print(config['repo'])
except Exception as err: 
    print("")    # Hopefully bash thinks this is a falsy value? 
    sys.exit(1)  # Error code for shell

    
