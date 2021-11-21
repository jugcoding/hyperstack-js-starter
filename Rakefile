# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require(:default)

require './rake/builder'

B = Rake::Builder
B.initialize(production: ENV['PROD'] == 'true')

B::CDN.target('https://unpkg.com') do
  add 'react@16/umd/react.development.js'
  add 'react-dom@16/umd/react-dom.development.js'
  add 'create-react-class@15.7.0/create-react-class.js'
  add 'history@5.1.0/umd/history.development.js'
  add 'react-router@6/umd/react-router.development.js'
  add 'react-router-dom@6.0.2/umd/react-router-dom.development.js'
  add 'react_ujs@2.6.1/react_ujs/dist/react_ujs.js', no_min: true
  add 'jquery@2.1.4/dist/jquery.js'
end

B::Sass.target './assets/css/styles.scss'

B::Opal.target './lib/runtime.rb'
B::Opal.target './app/application.rb'

B::Erb.target './assets/html/index.erb'

task :server do
  if B.production
    sh 'bundle exec rackup'
  else
    sh 'bundle exec foreman start --root=./ -f ./config/Procfile.dev'
  end
end

B::DefaultTargets.add
