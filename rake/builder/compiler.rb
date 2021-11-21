# frozen_string_literal: true

module Rake
  module Builder
    class Compiler
      include Rake::DSL

      module ClassMethods
        def target(source, **opts, &block)
          @instance ||= self.new
          @instance.add_asset(source, **opts)
          @instance.instance_exec(&block) if block_given?
        end
      end

      class << self
        def inherited(subclass)
          super(subclass)
          subclass.extend ClassMethods
        end
      end

      def name
        @name ||= self.class.name.split('::').last.downcase.to_sym
      end

      def target
        :compile
      end

      def dest(_asset)
        raise "you must define a dest(asset) method for #{name}"
      end

      def build(_asset)
        raise "you must define a build(asset) method for #{name}"
      end

      def dependencies(asset)
        asset.src
      end

      def add_asset(source, **opts)
        asset = Asset.new(source, **opts)
        dest(asset) { |destination| asset.build_to destination }
        Builder.assets[name] << asset

        add_targets(asset)
      end

      def add_targets(asset)
        Builder.targets[target] << name
        Builder.targets[name] << asset.dest

        file asset.dest => dependencies(asset) do
          compile(asset)
        end
      end

      def compile(asset)
        puts "Compiling #{asset.src} => #{asset.dest}..."

        asset.mkdir
        write(asset, build(asset))
      end

      def write(asset, build)
        File.binwrite(asset.dest, build)
      end
    end
  end
end
