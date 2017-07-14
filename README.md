# Multi-node [Cassandra](http://cassandra.apache.org) Cluster on [Kubernetes](http://kubernetes.io/)
Fork of an open-source Github project. This creates a Cassandra docker image that expects to be run in Kubernetes. It has a few custom pieces:
* custom-entrypoint.sh - this does a DNS lookup on the `cassandra-peers` service in order to join the cluster.

## Configuration Options

The following environment variables can be configured in the [Cassandra replication controller definition](cassandra-replication-controller.yml):

```sh
env:
  - name: CASSANDRA_CLUSTER_NAME
    value: Cassandra
  - name: CASSANDRA_DC
    value: DC1
  - name: CASSANDRA_RACK
    value: Kubernetes Cluster
  - name: CASSANDRA_ENDPOINT_SNITCH
    value: GossipingPropertyFileSnitch
```
