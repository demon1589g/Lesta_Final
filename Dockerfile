FROM python:3.10-slim

# Установка зависимостей для psycopg2 и других пакетов
RUN apt-get update && apt-get install -y gcc libpq-dev && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Экспортируем переменные для Flask (важно для запуска внутри контейнера)
ENV FLASK_APP=app
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000

# Открываем порт для доступа снаружи
EXPOSE 5000

# Инициализация базы (создание таблиц) при запуске контейнера
CMD ["sh", "-c", "flask db upgrade || flask shell -c 'from app import db; db.create_all()' && flask run"]

