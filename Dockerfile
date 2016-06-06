FROM seapy/rails-nginx-unicorn-pro:v1.1-ruby2.3.0-nginx1.8.1

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --force-yes libpq-dev


ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --without development test
ADD . /app

ADD config/btfoto.conf /etc/nginx/sites-enabled/default
