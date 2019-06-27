# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  Ruby: `2.6.3`
  Create and use the gemset: `rvm use 2.6.3@codecraft [--create]`
  Rails: `5.2.3`

* System dependencies
  `MySQL`

* Configuration
  ```
  cp config/samples/local_env.yml config
  ```
  Update `config/local_env.yml` with your corresponding values

* Database creation & initialization
  `rails db:setup`

* How to run the test suite
  `rspec --format=doc`

  Open `coverage/index.html` in a browser to see a detailed report of app's coverage

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
