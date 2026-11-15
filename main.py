import os
from dotenv import load_dotenv

load_dotenv()
app_name = os.getenv("APP_NAME")
api_key = os.getenv("API_KEY")

if not app_name:
    print("Ошибка конфигурации: Переменная APP_NAME не найдена в файле .env!")
else:
    print(f"Приложение: {app_name}")

    if api_key:
        print("API_KEY loaded: True")
    else:
        print("API_KEY loaded: False")