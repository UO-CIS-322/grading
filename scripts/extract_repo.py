"""
Extract the 'repo = ' line from a credentials file.
File must have fixed name credentials.py, in this directory
"""
import sys
try:
    import credentials
    print(credentials.repo)
except Exception as err: 
    print("")    # Hopefully bash thinks this is a falsy value? 
    sys.exit(1)  # Error code for shell

    
