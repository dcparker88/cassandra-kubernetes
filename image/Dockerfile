FROM cassandra:3.11.0
MAINTAINER dcparker88@gmail.com
ENV REFRESHED_AT 6/20/2017

# we will need to inject a secret in to this file from storeplay
# /etc/cassandra/jmxremote.password

RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install dnsutils wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# authentication for cql and nodetool
RUN sed -i 's/authenticator:.*/authenticator: PasswordAuthenticator/' /etc/cassandra/cassandra.yaml
RUN sed -i 's/authorizer:.*/authorizer: CassandraAuthorizer/' /etc/cassandra/cassandra.yaml

# set to "no" to allow remote nodetool.
ENV LOCAL_JMX no

# turn off remote password for nodetool, temporarily
# not sure how to manage this in the long-term, vault maybe?
RUN sed -i 's/jmxremote.authenticate=true*/jmxremote.authenticate=false/' /etc/cassandra/cassandra-env.sh

# set up the metrics output
COPY cassandra-metrics.yaml /etc/cassandra/cassandra-metrics.yaml
RUN echo "JVM_OPTS=\"\$JVM_OPTS -Dcassandra.metricsReporterConfigFile=cassandra-metrics.yaml\"" >> /etc/cassandra/cassandra-env.sh

# copy the needed metrics jars
RUN cd /usr/share/cassandra/lib && wget https://binrepo.target.com/artifactory/esv-deploy/cassandra/metrics-graphite/3.1.2/metrics-graphite-3.1.2.jar

COPY custom-entrypoint.sh /
ENTRYPOINT ["/custom-entrypoint.sh"]
CMD ["cassandra", "-f"]
