FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV FLASK_APP=app.py

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get update && apt-get install -y postgresql-client

COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

COPY app.py .

EXPOSE 5001

ENTRYPOINT ["sh", "./entrypoint.sh"]
CMD ["gunicorn", "--bind", "0.0.0.0:5001", "app:app"]