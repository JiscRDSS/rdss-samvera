#Endpoint that has the same effective name in the mapping and the model. objectRights maps to :object_rights
module Cdm
  module Messaging
    class ObjectRight < MessageMapper
      def array_value(mapping, object)
        object.object_rights.map do |right|
          hash_value(mapping.first, right)
        end
      end
    end
  end
end