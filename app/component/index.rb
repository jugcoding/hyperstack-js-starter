# frozen_string_literal: true

# app/hyperstack/components/index.rb
class Index < HyperComponent
  param :scope

  render(SECTION, class: :main) do
    UL(class: 'todo-list') do
      next bad_scope unless Todo.scope? scope

      Todo.send(scope).each do |todo|
        TodoItem(todo: todo)
      end
    end
  end

  def bad_scope
    LI(class: 'todo-item editing') { LABEL { "Bad path: #{scope}" } }
  end
end
