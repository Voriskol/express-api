# Используем образ линукс Alpine с версией node 19.5
FROM node:19.5.0-alpine


# Указываем рабочую директорию
WORKDIR /app

# Скопировать package.json и package.json-lock внутрь контейнера
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем все остальное приложение в контейнер
COPY . .

# Установить призму
RUN npm install -g prisma

# Генерируем prisma-client
RUN prisma generate

# Копируем схемы призмы 
COPY prisma/schema.prisma ./prisma/

# Открыть порт в нашем контейнере
EXPOSE 3000

# Запускаем наш сервер
CMD ["npm", "start"]
