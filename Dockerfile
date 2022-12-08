FROM alpine:3.17.0

WORKDIR /app

COPY requirements.txt /app

RUN apk update && \
  apk add --no-cache python3 py3-pip git && \
  pip3 install --upgrade pip && \
  pip3 install --no-cache-dir -r requirements.txt

EXPOSE 8080
CMD ["mkdocs", "serve", "--dev-addr=0.0.0.0:8080"]