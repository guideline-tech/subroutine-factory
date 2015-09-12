require 'active_support/inflector/methods'

module Subroutine
  module Factory
    class Builder

      def initialize(config, *args)
        @config = config
        @options = config.options
        @args = args
      end

      def execute!
        op = op_class.new(*input_args)
        @options[:befores].each{|block| block.call(op) }
        op.submit!
        output = extract_output(op)
        @options[:afters].each{|block| block.call(op, output) }
        output
      end

      protected

      def op_class
        klass = @options[:op].constantize
      end

      def input_args
        args = @args.dup
        overrides = args.extract_options!
        inputs = build_inputs(overrides)

        args.push(inputs)
        args
      end

      def build_inputs(overrides)
        out = {}
        @options[:inputs].each_pair do |k,v|
          if overrides.has_key?(k)
            out[k] = overrides[k]
          else
            out[k] = v.respond_to?(:call) ? v.call : v
          end
        end

        out
      end

      def extract_output(op)
        if @options[:output]
          return op.send(@options[:output])
        elsif @options[:outputs]
          @options[:outputs].inject({}){|out, output| out[output] = op.send(output); out }
        else
          op
        end
      end

    end
  end
end
