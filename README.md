# Lesta Final Project

## Как запустить проект локально

1. Клонировать репозиторий:
   git clone https://github.com/demon1589g/Lesta_Final.git
   cd Lesta_Final

2. Запустить проект:
   docker-compose up --build -d

## Как настроить Jenkins

1. Установить Jenkins и Docker.
2. Создать Pipeline (тип: Pipeline script from SCM):
   - SCM: Git
   - Repository URL: git@github.com:demon1589g/Lesta_Final.git
   - Credentials: SSH ключ Jenkins
   - Branch: main
3. Jenkinsfile уже в репозитории.

## Как работает CI/CD

- Jenkins запускает pipeline при каждом пуше в main:
  - Клонирует репозиторий
  - Собирает Docker-образ
  - Проверяет стиль кода через flake8
  - Публикует образ в DockerHub
  - По SSH подключается на сервер и перезапускает контейнер

![Jenkins Pipeline Screenshot](docs/images/Lesta.png)

## Примеры API-запросов

POST /submit

curl -X POST http://localhost:5000/submit \
  -H "Content-Type: application/json" \
  -d '{"name": "Kirill", "score": 88}'

GET /ping

curl http://localhost:5000/ping

GET /results

curl http://localhost:5000/results

[
  {"id": 1, "name": "Kirill", "score": 88, "timestamp": "2025-05-30T10:25:43"},
  {"id": 2, "name": "Roman", "score": 92, "timestamp": "2025-05-30T10:30:10"}
]

## Финальные данные

- Репозиторий: https://github.com/demon1589g/Lesta_Final.git
- Эндпоинт: http://37.9.53.201:5000/results
