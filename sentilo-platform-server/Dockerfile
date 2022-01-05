FROM openjdk:8
ARG FILE=sentilo-server
COPY ./appassembler /opt/sentilo
RUN ls -l /opt/sentilo
RUN chmod +x /opt/sentilo/bin/sentilo-server
ENTRYPOINT ["/opt/sentilo/bin/sentilo-server"]
