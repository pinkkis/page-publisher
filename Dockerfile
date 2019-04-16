FROM node:lts-alpine

LABEL "maintainer"="pinkkis <pinkkis@gmail.com>"
LABEL "repository"="https://github.com/pinkkis/page-publisher"

LABEL "com.github.actions.name"="Publish GH Pages Site"
LABEL "com.github.actions.description"="Publish your static site to your gh-pages"
LABEL "com.github.actions.icon"="book-open"
LABEL "com.github.actions.color"="blue"

COPY entrypoint.sh /

RUN apk update && \
    apk upgrade && \
    apk add ca-certificates git && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
