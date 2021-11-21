# frozen_string_literal: true

class EditItem < HyperComponent
  param :todo
  other :etc  # can be named anything you want

  fires :saved
  fires :cancel

  after_mount { JQuery[dom_node].focus }
  after_update { JQuery[dom_node].focus }

  render do
    INPUT(etc, placeholder: 'What is left to do today?', defaultValue: todo.title, key: todo)
      .on(:enter) do |evt|
        todo.update(title: evt.target.value)
        saved!
      end
      .on(:blur) { cancel! }
  end
end
