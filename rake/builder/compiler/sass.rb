# frozen_string_literal: true

require 'sassc'

module Rake
  module Builder
    class Sass < Compiler
      def dest(asset)
        yield Paths.static "css/#{asset.src.basename.sub_ext('.css')}"
      end

      def dependencies(asset)
        Rake::FileList["#{asset.src.dirname}/**/*"]
      end

      def build(asset)
        sass = File.read(asset.src)
        SassC::Engine.new(
          sass,
          load_paths: [asset.src.dirname.to_s],
          syntax:     asset.src.to_s.end_with?('sass') ? :sass : :scss,
          style:      Builder.production ? :compressed : :nested
        ).render
      end
    end
  end
end
