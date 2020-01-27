module Watir
  module Exception
    class Error < StandardError; end

    # TODO: rename Object -> Element?
    class UnknownObjectException < Error
      def initialize(msg = nil, query_scope = nil)
        @query_scope = query_scope
        super(msg)
      end

      def scope
        @query_scope
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
