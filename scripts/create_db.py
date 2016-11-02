"""
Create the database for the specified user
(who must not be siteUserAdmin)
"""

import pymongo
from pymongo import MongoClient
import sys

import secrets.admin_secrets
import secrets.client_secrets

MONGO_ADMIN_URL = "mongodb://{}:{}@{}:{}/admin".format(
    secrets.admin_secrets.admin_user,
    secrets.admin_secrets.admin_pw,
    secrets.admin_secrets.host, 
    secrets.admin_secrets.port)

try: 
    dbclient = MongoClient(MONGO_ADMIN_URL)
    db = getattr(dbclient, secrets.client_secrets.db)
    print("Got database {}".format(secrets.client_secrets.db))
    print("Attempting to create user")
    db.add_user(secrets.client_secrets.db_user,
                password=secrets.client_secrets.db_user_pw)
    print("Created user {}".format(secrets.client_secrets.db_user))
except Exception as err:
    print("Failed")
    print(err)


