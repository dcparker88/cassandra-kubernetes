#!/bin/bash
#
# Configure Cassandra seed nodes.

# Give Kubernetes time to add the new pod to the cassandra peer discovery service before we query DNS
sleep 5

my_ip=$(hostname --ip-address)
my_hostname=$(hostname)

CASSANDRA_SEEDS=$(host $PEER_DISCOVERY_SERVICE | \
    grep -v "not found" | \
    grep -v "connection timed out" | \
    grep -v $my_ip | \
    sort | \
    head -3 | \
    awk '{print $4}' | \
    xargs)

if [ ! -z "$CASSANDRA_SEEDS" ]; then
    export CASSANDRA_SEEDS
fi

# set the hostname in the metrics file
sed -i "s/HOSTNAME/$my_hostname/" /etc/cassandra/cassandra-metrics.yaml

# set the hostname of the store to get JMX working
RUN echo "JVM_OPTS=\"\$JVM_OPTS -Djava.rmi.server.hostname=$STORE_NAME\"" >> /etc/cassandra/cassandra-env.sh

/docker-entrypoint.sh "$@"
