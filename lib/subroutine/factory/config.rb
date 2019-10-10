require 'active_support/core_ext/hash/deep_merge'

module Subroutine
  module Factory
    class Config

      delegate :sequence, to: "::Subroutine::Factory"
      delegate :random, to: "::Subroutine::Factory"

      attr_reader :options

      def initialize(options)
        @options = options || {}

        parent(@options.delete(:parent)) if @options[:parent]

        sanitize!
      end

      def parent(parent)
        inherit_from(parent)
      end

      def validate!
        raise "Missing op configuration" unless @options[:op]
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

      def setup(&block)
        @options[:setups].push(block)
      end

      def before(&block)
        @options[:befores].push(block)
      end

      def after(&block)
        @options[:afters].push(block)
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
        @options[:outputs] = names
      end

      def extra(name, value = nil)
        @options[:extras][name.to_sym] = value
      end

      protected

      def inherit_from(parent)
        parent = ::Subroutine::Factory.get_config!(parent) unless parent.is_a?(::Subroutine::Factory::Config)
        @options.deep_merge!(parent.options)
        sanitize!
      end

      def sanitize!
        op(@options[:op]) if @options[:op]

        @options[:inputs] ||= {}
        @options[:inputs].each_pair{|k,v| input(k, v) }

        outputs(*@options[:outputs]) if @options[:outputs]
        output(@options[:output]) if @options[:output]

        @options[:setups] = @options[:setups].dup if @options[:setups]
        @options[:setups] ||= []

        @options[:befores] = @options[:befores].dup if @options[:befores]
        @options[:befores] ||= []

        @options[:afters] = @options[:afters].dup if @options[:afters]
        @options[:afters] ||= []

        @options[:extras] ||= {}
        @options[:extras].each_pair{|k,v| extra(k,v) }
      end

    end
  end
end
