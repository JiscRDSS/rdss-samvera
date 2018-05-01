#Endpoint that has the same effective name in the mapping and the model. objectRights maps to :object_rights
module Cdm
  module Messaging
    class ObjectRights < MessageMapper
      def hash_value(message_map, object)
        super
      end
    end
  end
end