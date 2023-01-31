FROM ruby:3-alpine

WORKDIR /MAKERSBNB

COPY . .

COPY Gemfile Gemfile.lock
RUN gem install pg
RUN bundle lock --add-platform x86_64-linux-musl --add-platform ruby

RUN bundle install

CMD ["./app.rb"]