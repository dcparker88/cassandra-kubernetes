FROM cassandra:3.11.0
MAINTAINER dcparker88@gmail.com
ENV REFRESHED_AT 6/20/2017

# we will need to inject a secret in to this file from storeplay
# /etc/cassandra/jmxremote.password

RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install dnsutils && \
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

# set the hostname of the store to get JMX working
# will need to figure out how to inject this a different way
ENV STORE_HOSTNAME cassandra.store9401.api.target.com
RUN echo "JVM_OPTS=\"\$JVM_OPTS -Djava.rmi.server.hostname=$STORE_HOSTNAME\"" >> /etc/cassandra/cassandra-env.sh

COPY custom-entrypoint.sh /
ENTRYPOINT ["/custom-entrypoint.sh"]
CMD ["cassandra", "-f"]
