module Cdm
  module Messaging
    class FileStorageType < MessageMapper
      def value(object, _)
        Enumerations::StorageType.http
      end
    end
  end
end
