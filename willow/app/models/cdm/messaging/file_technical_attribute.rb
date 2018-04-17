module Cdm
  module Messaging
    class FileTechnicalAttribute < MessageMapper
      def hash_value(*)
        {}
      end

      def array_value(*)
        []
      end
    end
  end
end