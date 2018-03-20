module Cdm
  module Messaging
    class FileHasMimeType < MessageMapper
      def value(object, _)
        object&.mime_type.present? 
      end
    end
  end
end
