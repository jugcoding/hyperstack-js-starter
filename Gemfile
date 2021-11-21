# frozen_string_literal: true

source 'https://rubygems.org'

## opal :
gem 'opal'
gem 'opal-activesupport'
gem 'opal-browser'
gem 'opal-jquery'

# latest hyperstack
git 'https://github.com/hyperstack-org/hyperstack', branch: 'edge', glob: 'ruby/*/*.gemspec' do
  gem 'rails-hyperstack'
end

## build :
gem 'sassc'
gem 'uglifier'

group :development do
  gem 'foreman'
  gem 'guard'
  gem 'guard-livereload'
  gem 'guard-rake'
  gem 'rack-livereload'
  gem 'rake'
  gem 'sinatra'
end
