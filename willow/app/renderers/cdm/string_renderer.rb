module Cdm
  class StringRenderer
    class << self
      include Utils

      private
      String.class_eval do
        def is_valid_uri?
          uri = URI.parse self
          uri.kind_of?(URI::HTTP)
        rescue URI::InvalidURIError
          false
        end
      end

      def sanitize(value)
        ERB::Util.h(value)
      end

      def render(value)
        sanitize(value)
      end

      public
      def call(value)
        render(value)
      end
    end
  end
end
