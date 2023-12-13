FROM python:3.10
RUN mkdir -p /app
COPY bandit4mal /app/bandit4mal
COPY bandit4mal.sh /app/bandit4mal.sh
RUN pip3 install wheel
RUN PBR_VERSION=1.2.3 pip3 install /app/bandit4mal
COPY entrypoint.sh /entrypoint.sh

CMD ["bandit"]
ENTRYPOINT ["/entrypoint.sh"]
