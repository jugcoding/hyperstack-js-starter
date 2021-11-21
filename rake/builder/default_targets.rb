# frozen_string_literal: true

module Rake
  module Builder
    module DefaultTargets
      module_function

      extend Rake::DSL

      def add
        Builder.targets.each do |name, dependencies|
          task name => dependencies.to_a
        end

        task(:cleanup) { Builder.cleanup }
        task(:setup_path) { Builder.setup_path }

        task setup: %i[setup_path compile]
        task rebuild: %i[cleanup setup]

        task default: :compile
      end
    end
  end
end
