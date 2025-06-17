# CDC (Change Data Capture) Demo
This project replicates table data from SQL Server to Postgres via Debezium and Kafka Connect.
Run the following command to start the environment.

`docker-compose -f docker/docker-compose.yml up`

## SQL Server
### Enable sql server agent
Login into the SQL Server docker container and run the following command. _The container will need to be restarted after this._

`/opt/mssql/bin/mssql-conf set sqlagent.enabled true`

### Setup source DB
Run the following source setup script to create the test db and table. And also enable CDC.

```
CREATE DATABASE TESTDB;
USE TESTDB;

CREATE TABLE messages(id INT, msg VARCHAR(255))

EXEC sys.sp_cdc_enable_db;

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo', 
@source_name   = N'messages',
@role_name     = NULL;
```

## Postgres
### Setup sink DB
Run the following script on postgres TESTDB to create the sink table
```
CREATE TABLE messages (
"id" INT8 NOT NULL,
"msg" VARCHAR(255),
PRIMARY KEY ("id")
);
```

## Kafka Connect
Run the following commands to create source and sink connectors

```
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:8083/connectors -d @source-connector.json;

curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:8083/connectors -d @sink-connector.json;
```

## Testing
Once the environment is setup we can start inserting/updating data in the source DB table.

`INSERT INTO dbo.messages VALUES(1, 'message 1');`

And this data will flow through to sink DB, which we can validate by querying the sink DB table.

`SELECT * FROM messages;`