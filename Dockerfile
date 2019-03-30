FROM node:lts-alpine

LABEL "maintainer"="pinkkis <pinkkis@gmail.com>"
LABEL "repository"="https://github.com/pinkkis/page-publisher"

LABEL "com.github.actions.name"="Publish GH Pages Site"
LABEL "com.github.actions.description"="Publish your static site to your gh-pages"
LABEL "com.github.actions.icon"="book-open"
LABEL "com.github.actions.color"="blue"

WORKDIR /app

COPY LICENSE README.md entrypoint.sh ./

RUN apk update && \
    apk upgrade && \
    apk add git && \
    chmod +x ./entrypoint.sh

COPY package*.json .
RUN npm install

COPY . .
RUN npm run build

ENTRYPOINT ["entrypoint.sh"]
