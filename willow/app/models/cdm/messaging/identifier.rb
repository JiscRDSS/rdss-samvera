module Cdm
  module Messaging
    class Identifier < MessageMapper
      def hash_value(message_map, object)
        super(message_map, object.identifier)
      end
    end
  end
end