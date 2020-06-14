# Customer Relationship Management - Ratings

## Overview

We have two sources of data:
- ratings stream: continuosly produces user ratings
- customer database: contains the demographics of customers

We ingest such data in Kafka and we join them using KSQL.

## Details

Start the ingestion architecture with:
```
docker-compose -f docker-compose-kafka.yml up -d
```

and wait 2 minutes to let containers be ready.

As soon as the components are ready, connect the customer database to Kafka, and execute the KSQL queries that allow for obtaining the `RANTINGS_WITH_CUSTOMER_DATA` topic.
```
docker-compose -f docker-compose-kafka.yml exec connect-debezium bash -c '/scripts/create-mysql-source.sh'
cat ksql-workshop.sql | docker-compose -f docker-compose-kafka.yml exec -T ksql-cli ksql http://ksql-server:8088
```

Start Telegraf and InfluxDB with:
```
docker-compose -f docker-compose-influx.yml up -d
```

Wait for influx to setup and the restart telegraf if needed.

```
docker-compose -f docker-compose-influx.yml restart telegraf
```

Then open Influx web interface and import the `ratings.json` dashboard.

Enjoy 😁