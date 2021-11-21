# frozen_string_literal: true

require 'sinatra/base'

SUB_FOLDER = ENV['PROD'] == 'true' ? 'prod' : 'debug'

class Backend < Sinatra::Base
  set :public_folder, "./dist/#{SUB_FOLDER}"

  get '/*' do # '/*' => to make livereload work
    send_file File.join(settings.public_folder, 'index.html')
  end

  # get %r{dist/cdns/(.*).map} do
  #   content_type :json
  #   {
  #     'version'        => 3,
  #     'file'           => params['captures'].first,
  #     'sources'        => [],
  #     'sourcesContent' => [],
  #     'names'          => [],
  #     'mappings'       => ';;;;;;;;;;;;;;'
  #   }.to_json
  # end
end
