source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

gem "rails", "~> 7.0.3", ">= 7.0.3.1"
gem "sprockets-rails"
# gem "sqlite3", "~> 1.4"
gem "pg"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
# gem "redis", "~> 4.0"
# gem "kredis"
# gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
# gem "sassc-rails"
# gem "image_processing", "~> 1.2"
gem "devise"
gem 'iex-ruby-client'
# gem "rest-client"
gem "figaro"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails'
  # gem "pg"
end

group :development do
  gem "web-console"
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # gem "rack-mini-profiler"
  # gem "spring"
  gem 'letter_opener', '~> 1.8', '>= 1.8.1'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem 'database_rewinder'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

gem "tailwindcss-rails", "~> 2.0"
