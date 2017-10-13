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
rm -f credentials.conf
# if [[ -f to_grade/secrets/client_secrets.py ]]; then
#    echo "Attempting to destroy database from prior student"
#    python3 scripts/destroy_database.py
# fi;

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

cp ${credentials} scripts/credentials.conf

#okay try and get data
author="`python scripts/extract_author.py`"
echo "Author: ${author}"
repo="`python scripts/extract_repo.py`"
echo "Repo: ${repo}"
if [[ "${repo}" ==  "" ]] ; then
    echo "Missing repository URL; can't go on"
    exit 1
fi

#Build their code
git clone -q ${repo}  to_grade
echo "Clone Complete"

if [[ ! -d to_grade/secrets ]]; then
   mkdir to_grade/secrets
fi

#Hopefully you have credentials
cp ${credentials} to_grade/secrets/client_secrets.py
cp admin_secrets.py to_grade/secrets
cp google_client_key.json to_grade/secrets

#try and run tests
pushd to_grade
echo "Last push to repo:"
git log | head -n 8 | grep Date
echo "Configuring"
bash ./configure 
echo "Configuration complete"
. env/bin/activate
echo "Testing ... they should have some test cases"
nosetests
echo "**********************************"
echo "*  ${author} "
echo "**********************************"
echo "Copying credentials"
cp ../${credentials} syllabus/credentials.ini

echo "Starting server with 'make run'"

make run 