FROM ruby:3.4.6-slim

ENV APP_PATH /var/app
ENV BUNDLE_VERSION 2.4.11
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV TMP_PATH /tmp/
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_PORT 3000

WORKDIR $APP_PATH

# copy entrypoint scripts and grant execution permissions
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
#COPY ./test-docker-entrypoint.sh /usr/local/bin/test-entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh #&& chmod +x /usr/local/bin/test-entrypoint.sh

# install dependencies for application
RUN apt-get update && apt-get install -y \
build-essential \
git \
libpq-dev \
postgresql-client \
libxml2-dev \
libxslt1-dev \
libyaml-dev \
nodejs \
npm \
imagemagick \
libvips \
&& npm install -g yarn \
&& rm -rf /var/lib/apt/lists/* \
&& mkdir -p $APP_PATH


RUN gem install bundler --version "$BUNDLE_VERSION" \
&& rm -rf $GEM_HOME/cache/*

RUN gem install rails foreman rspec-rails

# navigate to app directory
WORKDIR $APP_PATH

EXPOSE $RAILS_PORT

#ENTRYPOINT ["docker/entrypoint.sh"]
ENTRYPOINT [ "bundle", "exec" ]

