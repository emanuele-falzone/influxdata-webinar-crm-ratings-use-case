# demo-scene-ratings

```
docker-compose -f docker-compose-kafka.yml up -d
```

Wait some time to let containers be ready.

```
docker-compose -f docker-compose-kafka.yml exec connect-debezium bash -c '/scripts/create-mysql-source.sh'
```

```
cat ksql-workshop.sql | docker-compose -f docker-compose-kafka.yml exec -T ksql-cli ksql http://ksql-server:8088
```

```
docker-compose -f docker-compose-influx.yml up -d
```

Wait for influx to setup and the restart telegraf if needed.

```
docker-compose -f docker-compose-influx.yml restart telegraf
```

Then open Influx web interface and import the `ratings.json` dashboard.