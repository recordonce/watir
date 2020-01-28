module Watir
  module Exception
    class Error < StandardError; end

    # TODO: rename Object -> Element?
    class UnknownObjectException < Error
      def initialize(msg = nil, obj)
        @obj = obj
        super(msg)
      end

      def obj
        @obj
      end

      def xpath
        return unless @obj.respond_to?(:build)
        @obj.build[:xpath]
      end
    end
    class ObjectDisabledException < Error; end
    class ObjectReadOnlyException < Error; end
    class NoValueFoundException < Error; end
    class NoMatchingWindowFoundException < Error; end
    class UnknownFrameException < Error; end
    class LocatorException < Error; end
  end # Exception
end # Watir
