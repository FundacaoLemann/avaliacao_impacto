source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'active_admin_import', '3.0.0'
gem 'activeadmin'
gem 'activeadmin_medium_editor'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'devise-i18n'
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.5'
gem 'pg', '~> 0.18'
gem 'puma', git: 'https://github.com/caiosba/puma.git', ref: '9735729'
gem 'rails', '~> 5.1.4'
gem 'ransack'
gem 'rest-client'
gem 'rubocop-github'
gem 'sass-rails', '~> 5.0'
gem 'scenic'
gem 'sidekiq'
gem 'simple_form'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'whenever', require: false
gem 'select2-rails'
gem 'sentry-raven'

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.6'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
end
