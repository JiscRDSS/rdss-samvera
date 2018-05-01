module Cdm
  module Messaging
    class LicenceIdentifier < MessageMapper
      public
      def value(object, _)
        object
      end
    end
  end
end

