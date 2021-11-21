# frozen_string_literal: true

module ActiveRecord
  class Model
    module Scope
      def inherited(subclass)
        super(subclass)

        ## add default scopes :
        subclass.scope(:all) { current }
      end

      ## scope
      def scopes
        @scopes ||= []
      end

      def scope?(name)
        scopes.include? name
      end

      def scope(name, &block)
        scopes << name
        self.class.define_method(name, &block)
      end
    end
  end
end
