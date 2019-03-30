FROM debian:stable-slim

LABEL "maintainer"="pinkkis <pinkkis@gmail.com>"
LABEL "repository"="https://github.com/pinkkis/page-publisher"

LABEL "com.github.actions.name"="Publish GH Pages Site"
LABEL "com.github.actions.description"="Publish your static site to your gh-pages"
LABEL "com.github.actions.icon"="book-open"
LABEL "com.github.actions.color"="blue"

COPY LICENSE README.md /

RUN apt-get -y update && \
    apt-get -y install git && \
    apt-get -y install curl && \
    apt-get clean

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
