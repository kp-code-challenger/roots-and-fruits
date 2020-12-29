# Roots and Fruits

### The contrived edible plant API!

* Ruby version: 2.7

* Confg: Needs a `TREFLE_TOKEN` for the app to work. I set it in my `~/.bashrc`, but I'd normally use dotenv gem or similar for dev/test envs.

* Database creation: is your typical PostgreSQL workflow, e.g. `rails db:create` and `rails db:test:prepare`

* Test are run with `rspec`

* Deployment instructions: `git push heroku main`, `rails db:migrate` and make sure to set any desired ENV vars
