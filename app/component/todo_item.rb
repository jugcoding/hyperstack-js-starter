# frozen_string_literal: true

# app/hyperstack/components/todo_item.rb
class TodoItem < HyperComponent
  param :todo

  render(LI, class: 'todo-item editing') do
    @editing ? edit : view
  end

  def edit
    EditItem(class: :edit, todo: todo)
      .on(:saved, :cancel) { mutate @editing = false }
  end

  def view
    INPUT(type: :checkbox, class: :toggle, checked: todo.completed)
      .on(:change) { todo.update(completed: !todo.completed) }

    LABEL { todo.title }
      .on(:double_click) { mutate @editing = true }

    A(class: :destroy)
      .on(:click) { todo.destroy }
  end
end
