# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'devise', '~> 4.7', '>= 4.7.2'
gem 'jbuilder', '~> 2.7', '>= 2.7.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.12', '>= 3.12.6'
gem 'rails', '5.2.4.3'
gem 'sass-rails', '~> 5.1', '>= 5.1.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 4.11', '>= 4.11.1'
  gem 'rspec-rails', '~> 3.9', '>= 3.9.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', '~> 0.76.0'
  gem 'rubocop-rspec', '~> 1.36'
  gem 'spring', '>= 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.1'
  gem 'web-console', '>= 3.7.0'
end

group :test do
  gem 'capybara', '~> 2.18', '>= 2.18.0'
  gem 'database_cleaner', '~> 1.6', '>= 1.6.2'
  gem 'launchy', '~> 2.4', '>= 2.4.3'
  gem 'simplecov', '~> 0.15.1'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

ruby '2.5.0'
