-- ###################################################
-- These are the commands used during the workshop. 
-- You can use this file to catch up to certain stages
-- of the workshop if you want.
-- ###################################################

SET 'auto.offset.reset' = 'earliest';

CREATE STREAM RATINGS WITH (KAFKA_TOPIC='ratings', VALUE_FORMAT='AVRO');

CREATE STREAM CUSTOMERS_SRC WITH (KAFKA_TOPIC='asgard.demo.CUSTOMERS', VALUE_FORMAT='AVRO');

CREATE STREAM CUSTOMERS_SRC_REKEY \
        WITH (PARTITIONS=1) AS \
        SELECT * FROM CUSTOMERS_SRC PARTITION BY ID;

-- This SELECT is just a way to get KSQL to wait until a message has passed through it.
-- If it doesn't then the subsequent CREATE TABLE will fail because they schema won't 
-- be registered for the topic yet
SELECT * FROM CUSTOMERS_SRC_REKEY LIMIT 1;
CREATE TABLE CUSTOMERS WITH (KAFKA_TOPIC='CUSTOMERS_SRC_REKEY', VALUE_FORMAT ='AVRO', KEY='ID');

CREATE STREAM RATINGS_WITH_CUSTOMER_DATA WITH (PARTITIONS=1) AS \
SELECT R.RATING_TIME, R.CHANNEL, R.STARS, \
       C.CLUB_STATUS, C.GENDER \
FROM RATINGS R \
     INNER JOIN CUSTOMERS C \
       ON R.USER_ID = C.ID;
