FROM ubuntu:latest

MAINTAINER jakub.blaszczyk@sap.com

ENV DEBIAN_FRONTEND noninteractive
ENV MASTER_URL foo.yrdci.fra.hybris.com

RUN apt-get update && apt-get -y install curl 
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x kubectl && mv kubectl /usr/bin/kubectl
RUN kubectl config set-cluster my-cluster --server=http://$MASTER_URL:8000 --api-version=v1
