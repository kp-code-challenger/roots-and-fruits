# README

* Ruby version
2.7

* Configuration
Needs a `TREFLE_TOKEN` for the app to work. I set it in my ~/.bashrc, but I'd normally use dotenv gem or similar for dev/test envs.

* Database creation
Typical PostgreSQL `rails db:create`, `rails db:test:prepare`

* How to run the test suite
`rspec`

* Deployment instructions
Push to Heroku, `rails db:migrate` and make sure to set any desired ENV vars
