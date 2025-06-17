# Debezium connector config

curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:8083/connectors -d @source-connector.json;

curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:8083/connectors -d @sink-connector.json;

# curl -i -X DELETE localhost:8083/connectors/cdc-demo-source-connector