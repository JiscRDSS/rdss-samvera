module Cdm
  module Messaging
    class FileTechnicalAttributes < MessageMapper
      def hash_value(*)
        { fileTechnicalAttributes: '' }
      end
    end
  end
end