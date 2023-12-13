FROM python:3.10
RUN mkdir -p /app
COPY pypi.py /app/pypi.py
COPY rules.yara /app/rules.yara
RUN pip install wheel
RUN pip install yara-scanner
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/app/pypi.py"]
