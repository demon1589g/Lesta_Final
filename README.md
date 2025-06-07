# Lesta Final Project

## Как запустить проект локально

1. Клонируйте репозиторий:
   git clone https://github.com/demon1589g/Lesta_Final.git
   cd Lesta_Final

2. Убедитесь, что установлен Docker и docker-compose.

3. Запустите:
   docker-compose up --build -d

4. Проверьте:
   curl http://localhost:5000/ping

## Как настроить Jenkins

1. Установите Jenkins и Docker.
2. Создайте Pipeline с типом "Pipeline script from SCM":
   - SCM: Git
   - Repository URL: git@github.com:demon1589g/Lesta_Final.git
   - Credentials: SSH-ключ Jenkins
   - Branch: main
3. Jenkinsfile уже находится в репозитории.

## Как работает CI/CD

- Jenkins запускает pipeline при пуше в main:
  - Клонирует репозиторий
  - Собирает Docker-образ
  - Проверяет код через flake8
  - Пушит образ в DockerHub
  - Подключается по SSH и перезапускает контейнер

![Jenkins Pipeline Screenshot](docs/images/Lesta.png)

## Примеры API-запросов

Проверка доступности:
curl http://localhost:5000/ping

Добавление результата:
curl -X POST http://localhost:5000/submit \
  -H "Content-Type: application/json" \
  -d '{"name": "Kirill", "score": 88}'

Получение всех результатов:
curl http://localhost:5000/results

## Финальные данные

- Репозиторий: https://github.com/demon1589g/Lesta_Final.git
- Эндпоинт: http://37.9.53.201:5000/results
