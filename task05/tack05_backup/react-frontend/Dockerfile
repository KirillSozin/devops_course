FROM node:23-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/cache/nginx /var/run /tmp/client_temp /tmp/proxy_temp_path /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp \
  && chown -R nginx:nginx /var/cache/nginx /var/run /usr/share/nginx/html /etc/nginx /tmp/client_temp /tmp/proxy_temp_path /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp

USER nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
