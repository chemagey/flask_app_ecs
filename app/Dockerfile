FROM python:3.7-alpine

WORKDIR /app
COPY requirements.txt ./

RUN pip install -r requirements.txt

COPY hello_world.py .
ENV FLASK_APP hello_world.py

EXPOSE 8080

CMD flask run --host=0.0.0.0 --port=8080
