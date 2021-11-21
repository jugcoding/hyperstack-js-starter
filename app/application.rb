# frozen_string_literal: true

require 'component'
require 'model'

class TopLevelComponent < HyperComponent
  before_mount do
    Todo.create(title: 'my first todo', completed: false)
    Todo.create(title: 'my second todo', completed: false)
    Todo.create(title: 'completed todo', completed: true)
  end

  render(BrowserRouter) do
    SECTION(class: 'todo-app') do
      Header()
      Footer() unless Todo.count.zero?
      Routes do
        Route(path: '/', element: Index(scope: :all))
        Route(path: '/:scope', element: WithParams(to: Index))
      end
    end
  end
end
