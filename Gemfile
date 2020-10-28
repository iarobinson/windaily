source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '~> 4.4.1'
gem 'coffee-rails', '~> 5.0.0'
gem 'devise'
gem 'figaro'
gem 'friendly_id'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'material_icons'
gem 'mini_magick', '~> 4.8'
gem 'pg'
gem 'puma', '~> 3.12'
gem 'rails', '6.0.0'
gem 'sass-rails', '~> 5.0'
gem 'sendgrid-ruby'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'twilio-ruby'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 5.x'
gem 'turbolinks', '~> 5'

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'rails-controller-testing'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'rspec_junit_formatter'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
end

group :test do
  gem 'rspec'
  gem 'capybara', "~> 2.0"
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
