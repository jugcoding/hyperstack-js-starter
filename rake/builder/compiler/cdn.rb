# frozen_string_literal: true

require 'open-uri'

module Rake
  module Builder
    class CDN < Compiler
      def target
        :setup
      end

      def dest(asset)
        yield Paths.static "cdn/#{asset.src.basename}" unless Builder.production
      end

      def dependencies(_asset)
        nil
      end

      alias compiler_add_asset add_asset

      def add_asset(url, **_opts)
        @url = url
      end

      def add(cdn, **opts)
        compiler_add_asset(dev_name(cdn), ignore_www: !opts[:no_min] && Builder.production, **opts)
        return if opts[:no_min]

        compiler_add_asset(prod_name(cdn), ignore_www: !Builder.production, **opts)
      end

      def compile(asset)
        return if Builder.production

        super(asset)
      end

      def build(asset)
        URI.parse(asset.src.to_s).read
      end

      def dev_name(cdn)
        "#{@url}/#{cdn}"
      end

      def prod_name(cdn)
        prod_path = cdn.sub(/\.development\./, '.production.').to_pn.sub_ext('.min.js')
        "#{@url}/#{prod_path}"
      end
    end
  end
end
