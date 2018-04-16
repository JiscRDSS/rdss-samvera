module Cdm
  module Messaging
    class FileTechnicalAttribute < MessageMapper
      def hash_value(*)
        { fileTechnicalAttributes: '' }
      end
    end
  end
end