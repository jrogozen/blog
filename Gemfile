source 'https://rubygems.org'

gem 'rails', '4.1.6'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
# gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development

gem 'bower-rails'
gem 'ng-rails-csrf'

# pre-populate angular cache of templates so rails doesn't have to request it
gem 'angular-rails-templates'

group :test, :development do
  gem "rspec-rails"
  gem "rspec-its"
  gem "factory_girl_rails"
  gem "capybara"
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "selenium-webdriver"
  gem "phantomjs"
  gem "pry-byebug"
end

gem 'foreman'

group :production, :staging do
  gem 'rails_12factor'
  gem 'rails_stdout_logging'
  gem 'rails_serve_static_assets'
end
