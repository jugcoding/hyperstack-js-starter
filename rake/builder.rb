# frozen_string_literal: true

require 'pathname'
require 'set'

require_relative './builder/paths'
require_relative './builder/asset'
require_relative './builder/compiler'
require_relative './builder/compiler/cdn'
require_relative './builder/compiler/erb'
require_relative './builder/compiler/sass'
require_relative './builder/compiler/opal'
require_relative './builder/default_targets'

module Rake
  module Builder
    module_function

    extend Paths
    extend Rake::DSL

    class << self
      attr_reader :assets, :targets
      attr_accessor :production
    end

    def initialize(production: false)
      @production = production
      @assets = Hash.new { |h, k| h[k] = [] }
      @targets = Hash.new { |h, k| h[k] = Set.new }
    end

    def cleanup
      puts "cleanup #{Paths.dist}"
      sh "rm -rf #{Paths.dist}" if Paths.dist.exist?
    end

    def setup_path
      sh "mkdir -p #{Paths.dist}"
    end

    def minify(asset)
      asset.next

      puts "Minifying #{asset.src} ..."

      File.open(asset.dest, 'w').write(Uglifier.new(harmony: true).compile(File.read(asset.src)))
      sh "rm #{asset.src}"
      sh "gzip -9 -kf #{asset.dest}"
    end
  end
end
