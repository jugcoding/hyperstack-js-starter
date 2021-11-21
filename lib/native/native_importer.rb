# frozen_string_literal: true

class NativeImporter
  IMPORT = `globalThis`
  NATIVE = `window`

  class << self
    def import(components, from:)
      components.each do |comp|
        IMPORT.JS[comp] = NATIVE.JS[from].JS[comp]
      end
    end
  end
end
