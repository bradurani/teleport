FROM jruby:9.1-jdk

RUN apt-get update
RUN apt-get install -y maven

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD Gemfile /usr/src/app/
ADD Gemfile.lock /usr/src/app/
RUN bundle install --system

# Development Gems used in the Rakefile but not in the Gemfile
RUN gem install nokogiri
RUN gem install shoulda-context
RUN cd $(bundle show telekinesis) && rake ext:build
RUN cd $(bundle show telekinesis) && rake gem:build

ADD . /usr/src/app

CMD ["bundle","exec", "sidekiq", "-vr", "./sidekiq.rb"]
