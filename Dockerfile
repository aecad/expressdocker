# Run expressvpn in a container

FROM debian:bullseye-slim

LABEL maintainer="steele@healthlab.xyz"

ENV ACTIVATION_CODE Code
ENV LOCATION smart
ENV PREFERRED_PROTOCOL auto
ENV LIGHTWAY_CIPHER auto


ARG APP=expressvpn_3.28.0.6-1_amd64.deb


RUN apt-get update &&  apt-get install -y --no-install-recommends \
    libterm-readkey-perl ca-certificates wget expect iproute2 curl procps libnm0 w3m  screen \
    && rm -rf /tmp/*.deb \


COPY entrypoint.sh /tmp/entrypoint.sh
COPY expressvpnActivate.sh /tmp/expressvpnActivate.sh
COPY expressvpn_3.30.0.2-1_amd64.deb /tmp/expressvpn_3.30.0.2-1_amd64.deb

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]


