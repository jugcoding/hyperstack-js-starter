# frozen_string_literal: true

class String
  def to_pn
    Pathname.new(self)
  end
end

class Pathname
  def to_pn
    self
  end
end

module URI
  class Generic
    def to_pn
      self
    end
  end
end

module Rake
  module Builder
    class Asset
      attr_reader :opts

      def initialize(source, **opts)
        @builds = [source]
        @opts = opts
        @index = 0
      end

      def next
        @index += 1
      end

      def mkdir
        FileUtils.mkdir_p dest.dirname
      end

      def build_to(dest)
        @builds << dest
      end

      def src
        Paths.normalize @builds[@index]
      end

      def dest
        Paths.normalize @builds[@index + 1]
      end

      def www_path
        Paths.www_path @builds.last
      end
    end
  end
end
