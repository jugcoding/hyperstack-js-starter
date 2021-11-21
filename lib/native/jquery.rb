# frozen_string_literal: true

module JQuery
  module_function

  def find(selector)
    if `typeof #{selector}['$respond_to?'] == 'function'` && selector.respond_to?(:dom_node)
      selector = selector.dom_node
    end
    `jQuery(#{selector})`
  end

  def [](selector)
    find(selector)
  end
end
