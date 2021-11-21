# frozen_string_literal: true

class Todo < ActiveRecord::Model
  attributes title: '', completed: false

  scope(:completed) { where(completed: true) }
  scope(:active) { where(completed: false) }
end
