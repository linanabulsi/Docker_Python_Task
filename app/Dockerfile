FROM python:3.6

EXPOSE 5000

WORKDIR /app

COPY requirements.txt /app
RUN pip install -r requirements.txt

COPY get_statistics.sh /app
RUN chmod +x get_statistics.sh


ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.7.3/wait /wait
RUN chmod +x /wait

COPY waitfor.sh /waitfor.sh
RUN chmod +x /waitfor.sh

COPY current_statistics.sh /app
RUN chmod +x current_statistics.sh

COPY app.py /app


CMD ["/waitfor.sh"]

VOLUME ["/app"]
