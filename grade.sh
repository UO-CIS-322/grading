#! /bin/bash
# 
# Usage: grade.sh lastname
#
#    Looks for lastnamefirstname_*_client_secrets.py in 'credentials' directory,
#    which should be a collection of files downloaded from Canvas.
#
#    Expects to find repository url and author name in that file, along with
#    other information required to run the program.
#
# Clones the git repository and attempts to install and test it
# Also creates MongoDB database user for application; 
# May destroy old user before proceeding

#
#  Cleanup before starting next project
#
echo "Cleaning up ... "
rm -rf to_grade
rm -f credentials.py
if [[ -f to_grade/secrets/client_secrets.py ]]; then
   echo "Attempting to destroy database from prior student"
   python3 scripts/destroy_database.py
fi;

#
# Find the files and links we need
# 
prefix="$1"
credentials=`scripts/glob.sh ${prefix}`
if  [[ ! -f ${credentials} ]] ; then
    echo "Didn't match ${prefix} to a credentials file"
    exit 1
else
    echo "Using credentials file ${credentials}"
fi

cp ${credentials}  scripts/credentials.py
author="`python3 scripts/extract_author.py`"
echo "Author: ${author}"
repo="`python3 scripts/extract_repo.py`"
echo "Repo: ${repo}"
if [[ "${repo}" ==  "" ]] ; then
    echo "Missing repository URL; can't go on"
    exit 1
fi
git clone ${repo}  to_grade
if [[ ! -d to_grade/secrets ]]; then
   mkdir to_grade/secrets
fi
cp ${credentials} to_grade/secrets/client_secrets.py
cp admin_secrets.py to_grade/secrets
server="`python3 scripts/extract_server_name.py`.py"
if [[ "${server}" == "" ]]; then
    echo "Didn't find the server_main configuration line"
    exit 1
fi; 

pushd to_grade
echo "Last push to repo:"
git log | head -n 8 | grep Date
echo "Configuring"
bash ./configure 
echo "Configuration complete"
. env/bin/activate
echo "Attempting to create database for application"
cp ../scripts/create_db.py .  # Even if it clobbers the local copy
python3 create_db.py
if [[ ! -f ${server} ]]; then
    echo "server_main is ${server} but that file is not present"
    exit 1
fi;
echo "Starting server in ${server}"
python3 ${server}


