ENV['TREFLE_TOKEN'] ||= 'get-from-heroku' if Rails.env.test?

ENV.fetch('TREFLE_TOKEN')
