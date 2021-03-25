FROM python:3.8-alpine
MAINTAINER Some Dev

ENV PYTHONUNBUFFERED 1

RUN apk add --no-cache --virtual ..build-deps gcc musl-dev mariadb-dev\
    freetype-dev \
    fribidi-dev \
    harfbuzz-dev \
    jpeg-dev \
    lcms2-dev \
    openjpeg-dev \
    tcl-dev \
    tiff-dev \
    tk-dev \
    zlib-dev

RUN pip install --upgrade pip && pip install pipenv
COPY ./backend/Pipfile* /tmp/
RUN cd /tmp && pipenv lock --requirements > requirements.txt && pip install -r requirements.txt

RUN mkdir /app
WORKDIR /app

COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

RUN adduser -D user
USER user
