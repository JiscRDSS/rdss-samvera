#Endpoint that has the same effective name in the mapping and the model. objectRights maps to :object_rights
module Cdm
  module Messaging
    class ObjectRight < MessageMapper
      def hash_value(mapping, object)
        super(mapping, object.object_rights.first)
      end
    end
  end
end