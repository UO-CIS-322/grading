"""
Extract the 'server = ' line from a credentials file.
File must have fixed name credentials.py, in this directory
"""
try:
    import credentials
    server = credentials.server_main
    if server.endswith(".py"):
        server = server[:-3]
    print(server)
except Exception as err: 
    #print("***Unable to extract server line***")
    pass
