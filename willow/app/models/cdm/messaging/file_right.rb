#Endpoint that has the same effective name in the mapping and the model. objectRights maps to :object_rights
module Cdm
  module Messaging
    class FileRight < MessageMapper
      def hash_value(_, object)
        nil
      end
    end
  end
end