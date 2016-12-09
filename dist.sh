#! /bin/bash
#
# Usage: dist.h  credentials_folder  machine machine
#
# Distribute a directory with credentials turned in in canvas to the
# the 'grading' folders on the testing platforms.
#
# Pre-requisites:
#    The credentials_folder must not have spaces in the name; bash and
#    ssh do not work well together on escaping the space. 
#    The 'grading' folder must live in the top level of the user's
#    account on the target machines.
#    The target machines must be configured for automatic ssh and scp
#    authentication (using public keys in the ~/.ssh folder, and
#    ~/.ssh/config if the user name is different).
#
#
TARGET_FOLDER=grading
SOURCE_FOLDER=$1
shift
TARGET_MACHINES=$*

echo "Distributing ${SOURCE_FOLDER} to ${TARGET_FOLDER}/credentials "\
       "on ${TARGET_MACHINES}"

for target in ${TARGET_MACHINES}; do
    echo "Removing old credentials folder"
    ssh ${target} rm -rf ${TARGET_FOLDER}/credentials || true
    echo "Copying new credentials folder to ${target}:${TARGET_FOLDER}/credentials"
    scp -r ${SOURCE_FOLDER} ${target}:${TARGET_FOLDER}/credentials
done


