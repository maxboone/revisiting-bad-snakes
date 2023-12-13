FROM ubuntu:22.04
RUN mkdir -p /app/ossgadget
COPY ossgadget /app/ossgadget
RUN apt update && apt install unzip

RUN ln --symbolic /app/ossgadget/oss-characteristic /usr/bin/oss-characteristic \
    && ln --symbolic /app/ossgadget/oss-defog /usr/bin/oss-defog \
    && ln --symbolic /app/ossgadget/oss-detect-backdoor /usr/bin/oss-detect-backdoor \
    && ln --symbolic /app/ossgadget/oss-detect-cryptography /usr/bin/oss-detect-cryptography \
    && ln --symbolic /app/ossgadget/oss-diff /usr/bin/oss-diff \
    && ln --symbolic /app/ossgadget/oss-download /usr/bin/oss-download \
    && ln --symbolic /app/ossgadget/oss-find-domain-squats /usr/bin/oss-find-domain-squats \
    && ln --symbolic /app/ossgadget/oss-find-source /usr/bin/oss-find-source \
    && ln --symbolic /app/ossgadget/oss-find-squats /usr/bin/oss-find-squats \
    && ln --symbolic /app/ossgadget/oss-fresh /usr/bin/oss-fresh \
    && ln --symbolic /app/ossgadget/oss-health /usr/bin/oss-health \
    && ln --symbolic /app/ossgadget/oss-metadata /usr/bin/oss-metadata \
    && ln --symbolic /app/ossgadget/oss-reproducible /usr/bin/oss-reproducible \
    && ln --symbolic /app/ossgadget/oss-risk-calculator /usr/bin/oss-risk-calculator

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /root
