"""
Extract the 'author = ' line from a credentials file.
File must have fixed name credentials.py, in this directory
"""
try:
    import credentials
    print(credentials.author)
except Exception as err: 
    print("***Unable to extract author line***")
