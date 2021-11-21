# frozen_string_literal: true

module ActiveRecord
  class Model
    module Mutators
      include Hyperstack::State::Observable

      mutator :create do |opts|
        @current << new(opts)
      end

      mutator :add do |obj|
        @current << obj
      end

      mutator :destroy do |obj|
        @current.delete(obj)
      end

      mutator :update do |obj, **defs|
        defs.each do |field, value|
          obj.values[field] = value
        end
      end

      mutator :toggle do |obj, field|
        obj.values[field] = !obj.values[field]
      end

      ## mutators of objects contained inside the Model Collection :
      module Instance
        include Hyperstack::State::Observable

        mutator :destroy do
          self.class.destroy self
        end

        mutator :toggle do |field|
          self.class.toggle(self, field)
        end

        mutator :update do |**defs|
          self.class.update(self, **defs)
        end
      end
    end
  end
end
