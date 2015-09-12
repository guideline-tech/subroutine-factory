require 'active_support/core_ext/hash/deep_merge'

module Subroutine
  module Factory
    class Config

      delegate :sequence, to: "::Subroutine::Factory"

      attr_reader :options

      def initialize(options)
        @options = options || {}
        inherit_from(@options[:parent])
        @options[:inputs] ||= {}
      end

      def validate!
        unless @options[:op] raise "Missing op configuration"
      end

      def op(op_class)
        @options[:op] = case op_class
        when String
          op_class
        when Class
          op_class.name
        else
          op_class.to_s
        end
      end

      def input(name, value)
        @options[:inputs][name.to_sym] = value
      end

      def output(name)
        @options.delete(:outputs)
        @options[:output] = name
      end

      def outputs(*names)
        @options.delete(:output)
        @options[:outputs] ||= []
        @options[:outputs] |= names
      end

      def inherit_from(parent)
        return unless parent
        parent = ::Subroutine::Factory.get_config!(parent) unless parent.is_a?(::Subroutine::Factory::Config)
        @options.deep_merge!(parent.options)
      end

    end
  end
end
