#!/usr/bin/env bash
# Call this with three parameters
#   1: The password used to connect to the database
#   2: true/false; if set to true, the database is populated with additional example data
#   3: true/false; if set to true, the database is populated based on the .bak-file at /migrations/queries/initDB/init.bak
echo "Installing 'netcat' if not present..."
apt-get update && apt-get install -y netcat

echo "Installing 'flyway'..."
wget -qO- https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/5.2.4/flyway-commandline-5.2.4-linux-x64.tar.gz | tar xvz && ln -s `pwd`/flyway-5.2.4/flyway /usr/local/bin

echo "Waiting for MS SQL server for potential initial database restoration..."
while ! nc -z localhost 1433; do
  sleep 0.1
done

if [ "${3,,}" == "true" ]
then
  /opt/mssql-tools/bin/sqlcmd -U sa -P $1 -S localhost -Q "RESTORE DATABASE [localDB] FROM DISK = N'/migrations/queries/initDB/init.bak' WITH FILE = 1, MOVE N'music2me' TO N'/var/opt/mssql/data/m2m_de_v9.mdf', MOVE N'music2me_log' TO N'/var/opt/mssql/data/m2m_de_v9_log.ldf', NOUNLOAD, STATS = 5"
else
  echo "Running flyway database creation queries:"
  SCHEMARESULT=$(flyway migrate -url="jdbc:sqlserver://localhost:1433" -user="sa" -password="$1" -locations="filesystem:$PWD/queries/initDB")
  echo "Running flyway database creation result: $SCHEMARESULT"
fi

requestedQueries="filesystem:$PWD/queries/base"
if [ "${2,,}" == "true" ]
then
  requestedQueries+=",filesystem:$PWD/queries/exampleData"
fi

echo "Running flyway with the following queries: $requestedQueries"

if [ "${3,,}" == "true" ]
then
  SCHEMARESULT=$(flyway baseline -baselineVersion=1 -url="jdbc:sqlserver://localhost:1433;databaseName=localDB" -user="sa" -password="$1" -locations="$requestedQueries")
fi
SCHEMARESULT=$(flyway migrate -url="jdbc:sqlserver://localhost:1433;databaseName=localDB" -user="sa" -password="$1" -locations="$requestedQueries")
echo "Running flyway result: $SCHEMARESULT"