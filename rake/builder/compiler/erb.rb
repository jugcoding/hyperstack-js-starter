# frozen_string_literal: true

require 'erb'

module Rake
  module Builder
    class Erb < Compiler
      def dest(asset)
        yield Paths.root asset.src.basename.sub_ext('.html')
      end

      def build(asset)
        ERB.new(File.read(asset.src)).result(binding)
      end

      def scripts(name)
        Builder.assets[name].map do |asset|
          next if asset.opts[:ignore_www]

          "<script crossorigin src='#{asset.www_path}'></script>"
        end.compact.join("\n    ")
      end

      def stylesheets(name)
        Builder.assets[name].map do |source|
          "<link rel='stylesheet' href='#{source.www_path}'>"
        end.join("\n    ")
      end
    end
  end
end
