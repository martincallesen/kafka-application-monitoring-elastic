#!/usr/bin/env bash

REPLICATION_FACTOR=1

# List all topics
ALL_TOPICS=$(kafka-topics --bootstrap-server localhost:9092 --lists)

# Loop over all topics and check replication factor
for TOPIC in $ALL_TOPICS
do
    RESULT=$(kafka-topics --bootstrap-server localhost:9092 --describe --topic $TOPIC | grep "ReplicationFactor: $REPLICATION_FACTOR" | awk '{print substr($1,7)}')
    if [[ "${RESULT}" != -z ]]; then
      kafka-topics --bootstrap-server localhost:9092 --delete --topic $TOPIC
    fi
done