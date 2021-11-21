# frozen_string_literal: true

require 'opal'

require 'hyperstack'
`window.HyperstackOpts = {'transport': 'none'}`

def pp(msg)
  `console.log(#{msg})`
end

require 'native/native_importer'
require 'native/jquery'
require 'native/react_router_v6'

require 'active_record'

Document.ready? do
  Element['[data-hyperstack-mount]'].each do |mount_point|
    component_name = mount_point.attr('data-hyperstack-mount')
    component      = nil

    # rubocop:disable Lint/RescueException
    begin
      component = Object.const_get(component_name)
    rescue Exception
      message = "Could not find Component class named #{component_name}"
      `console.error(#{message})`
      next
    end
    # rubocop:enable Lint/RescueException

    params = Hash[*Hash.new(mount_point.data).collect do |name, value|
                    [name.underscore, value] unless name == 'reactrbMount'
                  end.compact.flatten(1)]

    element = Hyperstack::Component::ReactAPI.create_element(component, params)

    Hyperstack::Component::ReactAPI.render(element, mount_point)
  end
end
