# frozen_string_literal: true

require 'active_record/attributes'
require 'active_record/observers'
require 'active_record/mutators'
require 'active_record/scope'

module ActiveRecord
  class Model
    include Hyperstack::State::Observable

    class << self
      include Enumerable

      state_reader :current

      def initialize
        super
        @current = []
      end

      def each(&block)
        current.each(&block)
      end

      include Attributes
      include Observers
      include Mutators
      include Scope
    end

    state_reader :values

    def initialize(opts = {})
      opts = self.class.default_value.merge opts
      @values = opts
    end

    include Observers::Instance
    include Mutators::Instance
  end
end
