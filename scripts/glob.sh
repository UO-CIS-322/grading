#! /bin/bash
# Expand file name with matching prefix in credentials subdir 
# Usage:  glob caluya
#
# (Argument is a prefix of the file to find)
# Should print credentials/caluyaelijah_13197_3306356_secrets.py
#   by globbing a matching file name in credentials
# 
LOOK_IN=credentials   # The folder where we're looking for these files
echo ${LOOK_IN}/${1}*
