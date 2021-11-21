# frozen_string_literal: true

class Header < HyperComponent
  before_mount { @new_todo = Todo.new }

  render(HEADER) do
    H1 { 'todos' }
    EditItem(class: 'new-todo', todo: @new_todo)
      .on(:saved) do
        Todo.add @new_todo
        mutate @new_todo = Todo.new
      end
  end
end
