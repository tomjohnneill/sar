FROM madetech/rails-deps:ruby2.4.1

RUN mkdir -p /app

WORKDIR /app
ENV BUNDLE_PATH /bundle
COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install

WORKDIR /app

EXPOSE 3000
