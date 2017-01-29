FROM jruby:9.1-onbuild
CMD ["bundle","exec", "sidekiq", "-vr", "./sidekiq.rb"]
