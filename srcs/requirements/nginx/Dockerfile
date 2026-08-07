# Simple nginx Dockerfile
FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

COPY index.html /usr/share/nginx/html/
EXPOSE 80
