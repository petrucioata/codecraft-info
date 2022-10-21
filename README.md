# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  Ruby: `2.7.4`
  Create and use the gemset: `rvm use 2.7.4@codecraft [--create]`
  Rails: `6.1.7`

* System dependencies
  `MySQL`

* Configuration
  ```
  cp config/samples/local_env.yml config
  cp config/samples/storage.yml config
  ```
  Update `config/local_env.yml` with your corresponding values

* Database creation & initialization
  `rails db:setup`

* Handle events on file system modifications
  `bundle exec guard`

* How to run the test suite
  `rspec --format=doc`

  Open `coverage/index.html` in a browser to see a detailed report of app's coverage

* Admin access
  For admin access go to `/admin` and log in with your admin credentials.
