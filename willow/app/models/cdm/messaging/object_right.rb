#Endpoint that has the same effective name in the mapping and the model. objectRights maps to :object_rights
module Cdm
  module Messaging
    class ObjectRight < MessageMapper
      def hash_value(message_map, object)
        super(message_map, object.object_rights.to_a.first)
      end
    end
  end
end