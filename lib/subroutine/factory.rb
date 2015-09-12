require 'subroutine'
require "subroutine/factory/version"
require "subroutine/factory/config"
require "subroutine/factory/builder"
require "subroutine/factory/spec_helper"

module Subroutine
  module Factory

    @@configs = {}
    @@sequence = 1

    def self.define(name, options = {}, &block)
      config = ::Subroutine::Factory::Config.new(options)
      @@configs[name.to_sym] = config
      config.instance_eval(&block) if block_given?
      config
    end

    def self.get_config(name)
      @@configs[name.to_sym]
    end

    def self.get_config!(name)
      config = get_config(name)
      raise "Unknown Subroutine::Factory `#{name}`" unless config
      return config
    end

    def self.create(name, *args)
      config = get_config!(name)
      builder = ::Subroutine::Factory::Builder.new(config, *args)
      builder.execute!
    end

    def self.sequence(lambda)
      i = ++@@sequence
      Proc.new{ lambda.call(i) }
    end

  end
end
