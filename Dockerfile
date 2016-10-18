FROM seapy/rails-nginx-unicorn-pro:v1.1-ruby2.3.0-nginx1.8.1

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --force-yes libpq-dev

# https://github.com/mileszs/wicked_pdf/issues/53
# RUN wget http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.9.9-static-amd64.tar.bz2
# RUN tar xvjf wkhtmltopdf-0.9.9-static-amd64.tar.bz2
# RUN mv wkhtmltopdf-amd64 /usr/local/bin/wkhtmltopdf
# RUN chmod +x /usr/local/bin/wkhtmltopdf

#RUN wget http://download.gna.org/wkhtmltopdf/0.12/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
#RUN tar xvjf wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
#RUN mv wkhtmltox/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf
#RUN chmod +x /usr/local/bin/wkhtmltopdf

#sudo add-apt-repository ppa:ecometrica/servers
RUN apt-get update
RUN apt-get install -y --force-yes wkhtmltopdf


ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --without development test
ADD . /app

ADD config/btfoto.conf /etc/nginx/sites-enabled/default

# Backup Gem
RUN apt-get update && apt-get install -y --force-yes postgresql-9.5 postgresql-client-9.5 postgresql-contrib-9.5
