# Run expressvpn in a container

FROM debian:bullseye-slim

LABEL maintainer="aecad@pro"

ENV ACTIVATION_CODE Code
ENV LOCATION smart
ENV PREFERRED_PROTOCOL auto
ENV LIGHTWAY_CIPHER auto




RUN apt-get update &&  apt-get install -y --no-install-recommends \
    libterm-readkey-perl ca-certificates wget expect iproute2 curl procps libnm0 w3m  screen



COPY entrypoint.sh /tmp/entrypoint.sh
COPY expressvpnActivate.sh /tmp/expressvpnActivate.sh
COPY expressvpn_3.30.0.2-1_amd64.deb /tmp/expressvpn_3.30.0.2-1_amd64.deb


ARG APP=expressvpn_3.30.0.2-1_amd64.deb

RUN dpkg -i /tmp/${APP} \
    && rm -rf /tmp/*.deb

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]


