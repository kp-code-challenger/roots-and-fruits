# Roots and Fruits
### The contrived edible plant API!

* Heroku URL: https://roots-and-fruits.herokuapp.com/plants

* What is it? See [the specs](https://github.com/kp-code-challenger/roots-and-fruits/blob/main/spec/regression/app_spec.rb) for capabilities. It's basically a thin caching layer over the Trefle API.

* Ruby version: 2.7

* Confg: Needs a `TREFLE_TOKEN` for the app to work. I set it in my `~/.bashrc`, but I'd normally use dotenv gem or similar for dev/test envs.

* Database creation: is your typical PostgreSQL workflow, e.g. `rails db:create` and `rails db:test:prepare`

* Test are run with `rspec`

* Deployment instructions: `git push heroku main`, `rails db:migrate` and make sure to set any desired ENV vars
