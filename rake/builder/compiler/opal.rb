# frozen_string_literal: true

require 'opal'

module Rake
  module Builder
    class Opal < Compiler
      def dest(asset)
        yield Paths.static "opal/#{asset.src.basename.sub_ext('.js')}"
        yield Paths.static "opal/#{asset.src.basename.sub_ext('.min.js')}" if Builder.production
      end

      def dependencies(asset)
        Rake::FileList["#{asset.src.dirname}/**/*.rb"]
      end

      def build(asset)
        builder = ::Opal::Builder.new
        builder.append_paths(asset.src.dirname.to_s)

        builder.build(asset.src.basename.to_s, source_map_enabled: !Builder.production)
      end

      def write(asset, build)
        File.open(asset.dest, 'wb') do |f|
          f.puts build.to_s
          f.puts build.source_map.to_data_uri_comment unless Builder.production
        end

        Builder.minify(asset) if Builder.production
      end
    end
  end
end
