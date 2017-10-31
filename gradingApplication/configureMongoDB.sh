#! /bin/bash
set -e

echo "Setting up default settings"
rm -rf /var/lib/mongodb/*
cat > /etc/mongod.conf <<'EOF'
storage:
  dbPath: /var/lib/mongodb
  directoryPerDB: true
  journal:
    enabled: true
  engine: "wiredTiger"
 
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log
 
net:
  port: 27017
  bindIp: 0.0.0.0
  maxIncomingConnections: 100
 
replication:
  oplogSizeMB: 128
  replSetName: "rs1"
 
security:
  authorization: enabled
 
EOF
 
mongod --verbose &
sleep 5
 
mongo admin <<'EOF'
use admin
rs.initiate()
exit
EOF
 
sleep 5
 
echo "Adding admin user"
mongo admin <<'EOF'
use admin
rs.initiate()
var user = {
  "user" : "admin",
  "pwd" : "admin",
  roles : [
      {
          "role" : "userAdminAnyDatabase",
          "db" : "admin"
      }
  ]
}
db.createUser(user);
exit
EOF
 
echo "Complete"