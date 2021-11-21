# frozen_string_literal: true

require 'rack-livereload'
require File.absolute_path('backend/backend.rb')

production = ENV['PROD'] == 'true'

if production
  use Rack::Static, urls: ['/static'], root: 'dist/prod', index: 'index.html', gzip: true
else
  use Rack::LiveReload, source: :livereload
end

run Backend
