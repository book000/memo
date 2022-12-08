FROM alpine:3.17.0

WORKDIR /app
RUN apk update && \
  apk add --no-cache python3 py3-pip git && \
  pip3 install --upgrade pip && \
  pip3 install mkdocs mkdocs-material mkdocs-git-revision-date-localized-plugin mkdocs-awesome-pages-plugin

EXPOSE 8080
CMD ["mkdocs", "serve", "--dev-addr=0.0.0.0:8080"]