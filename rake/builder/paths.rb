# frozen_string_literal: true

module Rake
  module Builder
    module Paths
      module_function

      def kind
        Builder.production ? 'prod' : 'debug'
      end

      def root(path)
        path
      end

      def static(path)
        "static/#{path}"
      end

      def normalize(path)
        path_s = path.to_s

        ## source files start with './' ot 'https://':
        return path.to_pn if path_s.start_with?('.') || path_s.start_with?('https://')

        "#{dist}/#{path}".to_pn
      end

      def dist
        "./dist/#{kind}".to_pn
      end

      def www_path(path)
        if path.to_s.start_with? 'https://'
          path
        else
          "/#{path}"
        end
      end
    end
  end
end
