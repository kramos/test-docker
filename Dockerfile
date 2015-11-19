#FROM ruby:2.2.3-slim
FROM ruby:2.2.3
MAINTAINER markosrendell@gmail.com

ENV SERVERSPEC_VERSION 2.17.1
ENV DOCKERAPI_VERSION 1.22.4

RUN gem install serverspec -v ${SERVERSPEC_VERSION} 
RUN gem install docker-api -v ${DOCKERAPI_VERSION}

WORKDIR /tests

CMD rake spec
