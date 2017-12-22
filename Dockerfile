FROM bluebu/rails-alpine:rails4

RUN apk --update --upgrade add postgresql-dev \
  && apk add ca-certificates wget \
  && update-ca-certificates

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /app

RUN wget https://s3.eu-central-1.amazonaws.com/btfoto/wkhtmltopdf-0.9.9-static-amd64.tar.bz2
RUN tar xvjf wkhtmltopdf-0.9.9-static-amd64.tar.bz2
RUN mv wkhtmltopdf-amd64 /app/wkhtmltopdf
RUN chmod +x /app/wkhtmltopdf

WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5 --without development test

# Set Rails to run in production
ENV RAILS_ENV production
ENV RACK_ENV production

# Copy the main application.
COPY . ./

# Precompile Rails assets
RUN bundle exec rake assets:precompile

# Start puma
CMD ["foreman", "start", "-f", "Procfile"]
