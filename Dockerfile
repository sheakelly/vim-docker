FROM ubuntu:14.04

RUN apt-get update && \
    apt-get install -y vim

CMD vim
