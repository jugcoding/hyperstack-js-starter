# frozen_string_literal: true

# app/hyperstack/components/footer.rb
class Footer < HyperComponent
  def link_item(path)
    LI { NavLink(to: "/#{path}", style: { marginRight: 10 }) { path.camelize } }
  end

  render(DIV, class: :footer) do
    SPAN(class: 'todo-count') do
      # pluralize returns the second param (item) properly
      # pluralized depending on the first param's value.
      "#{pluralize(Todo.active.count, 'item')} left"
    end
    UL(class: :filters) do
      link_item(:all)
      link_item(:active)
      link_item(:completed)
    end
  end
end
