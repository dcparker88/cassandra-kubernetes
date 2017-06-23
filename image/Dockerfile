FROM cassandra:3.10
MAINTAINER dcparker88@gmail.com
ENV REFRESHED_AT 6/20/2017

# we will need to inject a secret in to this file from storeplay
# /etc/cassandra/jmxremote.password
# temporarily turn off remote authentication

RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install dnsutils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# authentication for cql and nodetool
#RUN sed -i 's/authenticator:.*/authenticator: PasswordAuthenticator/' /etc/cassandra/cassandra.yaml
#RUN sed -i 's/authorizer:.*/authorizer: CassandraAuthorizer/' /etc/cassandra/cassandra.yaml
#ENV LOCAL_JMX no

COPY custom-entrypoint.sh /
ENTRYPOINT ["/custom-entrypoint.sh"]
CMD ["cassandra", "-f"]
