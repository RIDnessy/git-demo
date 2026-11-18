# Мой первый аккуратный репозиторий

Этот проект демонстрирует правильную работу с секретами и конфигурацией с помощью переменных окружения.

## Как запустить проект

1. **Клонируйте репозиторий:**
   ```bash
   git clone https://github.com/RIDnessy/git-demo.git
   cd git-demo

2. Создайте и активируйте виртуальное окружение:
    python -m venv .venv

# Для Windows:
.venv\Scripts\activate

# Для macOS / Linux:
python3 -m venv .venv
source .venv/bin/activate

3. Установите зависимости:\
    pip install -r requirements.txt

4. Настройте переменные окружения: Скопируйте файл .env.example в .env:

# Для Windows:
copy .env.example .env

# Для macOS / Linux:'
cp .env.example .env

Назначение переменных:
APP_NAME — название приложения (используется для вывода в консоль).
API_KEY — секретный ключ доступа (в целях безопасности не выводится на экран).

5. Запустите программу:
python main.py

