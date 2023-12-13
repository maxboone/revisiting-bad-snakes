FROM ghcr.io/datadog/guarddog

USER root
COPY entrypoint.sh /entrypoint.sh
RUN apt update && apt install unzip

USER guarddog
ENTRYPOINT ["/entrypoint.sh"]
