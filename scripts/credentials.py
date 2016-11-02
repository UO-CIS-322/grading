# MongoDB client secrets
#    A MongoDB instance (mongod process) can have several 'databases',
#    each of which has its own authorized users. Your application runs
#    with a particular user on a particular database ... to install and
#    test your project, I'll run a script to create this user before
#    I run your actual application.  The database, user, and password are
#    arbitrary, except that you should not use 'admin' or 'test', which
#    are special built-in databases. 
#
# As a convenience, we will use this same credentials file to drive the
# process of installing and testing your project.  For this we will need
# your repository URL and your name.
#
author = "Your name here"                               # As it appears in Canvas
repo = "https://github.com/UO-CIS-322/proj6-mongo.git"  # Replace with yours
server_main = "flask_main"                              # flask_main.py is my main file

# The database we will use within the MongoDB instance
#
db = "wheat"

# The MongoDB user who will have access to read and write this database.
# This 'user' represents your application, not you.  It should not be the
# same as your administrative user. 
# 
db_user = "mcdonald"
db_user_pw = "hadaduck"


