module Subroutine
  module Factory
    module SpecHelper

      def factory(*args)
        ::Subroutine::Factory.create(*args)
      end

      def factory!(*args)
        factory(*args)
      end

      def factory_inputs(*args)
        ::Subroutine::Factory.inputs(*args)
      end

    end
  end
end
