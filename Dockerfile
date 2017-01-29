FROM jruby:9.1-onbuild
RUN apt-get update
RUN apt-get install -y maven

# Development Gems used in the Rakefile but not in the Gemfile
RUN gem install nokogiri
RUN gem install shoulda-context
RUN cd $(bundle show telekinesis) && rake ext:build
RUN cd $(bundle show telekinesis) && rake gem:build
CMD ["bundle","exec", "sidekiq", "-vr", "./sidekiq.rb"]
