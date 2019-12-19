FROM ruby:2.6.5-alpine

ENV APP /app

RUN apk add alpine-sdk imagemagick6-dev

RUN mkdir $APP
WORKDIR $APP

COPY Gemfile $APP/Gemfile
COPY Gemfile.lock $APP/Gemfile.lock
RUN bundle install
