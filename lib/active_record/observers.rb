# frozen_string_literal: true

module ActiveRecord
  class Model
    module Observers
      def count
        current.size
      end

      def empty?
        current.empty?
      end

      def where(opts)
        current.filter { |obj| obj.match?(opts) }
      end

      ## mutators of objects contained inside the Model Collection :
      module Instance
        def match?(opts)
          opts.each do |key, value|
            return false if values[key] != value
          end

          true
        end
      end
    end
  end
end
