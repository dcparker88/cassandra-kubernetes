FROM cassandra:3.10
MAINTAINER dcparker88@gmail.com
ENV REFRESHED_AT 6/20/2017

RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install dnsutils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY custom-entrypoint.sh /
ENTRYPOINT ["/custom-entrypoint.sh"]
CMD ["cassandra", "-f"]
