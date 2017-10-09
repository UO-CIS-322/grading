NAMES=`grep -v '^#' user_config.sh` #read name(s) from user_config.conf file
for NAME in $NAMES; do
   echo "Grading projects for $NAME"
   grade.sh $NAME
done