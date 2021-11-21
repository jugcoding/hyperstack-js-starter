# frozen_string_literal: true

class ReactRouterV6 < NativeImporter
  import %i[Routes Route], from: :ReactRouter
  import %i[BrowserRouter NavLink], from: :ReactRouterDOM

  ## useParams hook fix :
  IMPORT.JS[:WithParams] = proc do |props|
    params = NATIVE.JS[:ReactRouter].JS.useParams
    to = props.JS[:to].to_n
    props = `Object`.JS.assign(params, props)
    `delete #{props}.to`
    NATIVE.JS[:React].JS.createElement(to, props)
  end
end
