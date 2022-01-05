FROM ubuntu:20.04
ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ARG DEBIAN_FRONTEND="noninteractive"
RUN apt-get -y update && apt-get -y install tzdata openjdk-8-jdk openjdk-8-jre && apt-get -y install git maven
RUN git clone https://github.com/sentilo/sentilo.git sentilo
RUN sed -i 's/127.0.0.1/sentilo-catalog-web/g' sentilo/sentilo-platform/sentilo-platform-service/src/main/resources/properties/integration.properties
RUN sed -i 's/127.0.0.1/sentilo-redis/g' sentilo/sentilo-platform/sentilo-platform-service/src/main/resources/properties/jedis-config.properties
RUN chmod +x sentilo/scripts/buildSentilo.sh && ./sentilo/scripts/buildSentilo.sh
CMD ["cp", "-R", "/sentilo", "/tmp/"]
