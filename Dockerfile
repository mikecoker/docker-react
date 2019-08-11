#create node builder
FROM node:alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

RUN npm run build 

# create nginx runner
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

#auto starts nginx