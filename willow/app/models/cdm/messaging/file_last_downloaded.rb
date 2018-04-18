module Cdm
  module Messaging
    class FileLastDownloaded < MessageMapper
      def hash_value(_, object)
        {
          dateType: Enumerations::DateType.issued,
          # Default timestamp until JSON Schema is updated. 
          # dateValue: begin FileDownloadStat.where(file_id: object.original_file.id).first.downloads rescue Time.at(0).rfc3339 end
          dateValue: value(object, _)
        }
      end

      def array_value(_, object)
        [
          hash_value(_, object)
        ]
      end

      def value(object, _)
        object&.date_modified&.rfc3339 || Time.at(0).rfc3339
      end
    end
  end
end
