#! /bin/bash
pushd user_data
NAMES=`grep -v '^#' user_config.conf` #read name(s) from user_config.conf file
PROJECTS=`grep -v '^#' projects_config.conf` #read projects(s) from projects_config.conf file

mkdir ../credentials

for NAME in $NAMES; do
   for PROJECT in $PROJECTS; do
      echo "Adding credentials to credentials folder"
      cp projects/$PROJECT/credentials.ini ../credentials/$NAME-$PROJECT-credentials.ini
   done
   echo "Grading projects for $NAME"
   bash ../grade.sh $NAME
done
popd