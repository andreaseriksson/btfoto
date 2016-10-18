FROM seapy/rails-nginx-unicorn-pro:v1.1-ruby2.3.0-nginx1.8.1

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --force-yes libpq-dev

RUN wget http://download.gna.org/wkhtmltopdf/0.12/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
RUN tar xvjf wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
RUN mv wkhtmltox/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf
RUN chmod +x /usr/local/bin/wkhtmltopdf

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --without development test
ADD . /app

ADD config/btfoto.conf /etc/nginx/sites-enabled/default

# Backup Gem
RUN apt-get update && apt-get install -y --force-yes postgresql-9.5 postgresql-client-9.5 postgresql-contrib-9.5
