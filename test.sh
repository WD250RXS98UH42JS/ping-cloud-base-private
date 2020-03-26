#!/bin/sh

REPLICAS=$(kubectl get pods -l=role=pingfederate-engine -o jsonpath={.items..metadata.name})

CSD_FILES=
for REPLICA in $REPLICAS; do
    echo $REPLICA
done