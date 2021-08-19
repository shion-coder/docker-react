FROM node:alpine as builder

WORKDIR /app

COPY package.json .
COPY package-lock.json .


RUN npm install && npm cache clean --force

COPY . .

RUN npm run build

FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html