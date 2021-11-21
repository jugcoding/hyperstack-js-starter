# frozen_string_literal: true

# frozen_string_literal: true

module ActiveRecord
  class Model
    module Attributes
      ## define model attributes :
      attr_reader :default_value

      def attributes(**attributes)
        @default_value = attributes
        attributes.each_key do |key|
          define_method key do
            values[key]
          end
        end
      end
    end
  end
end
