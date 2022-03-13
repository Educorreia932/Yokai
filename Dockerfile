FROM ubuntu:22.04

RUN apt update
RUN apt install -y git
RUN apt install -y software-properties-common
RUN apt install -y python3 python3-apt
RUN apt install -y sudo 

WORKDIR ~/Dotfiles

COPY . .

RUN ./install
RUN sudo ./install -p dotbot_plugin_aptget/aptget.py -c packages.conf.yaml
