# Standard mapping for Person. Note this is hard called from the ObjectPersonRole as part of the override defined there.
module Cdm
  module Messaging
    class PersonIdentifier < MessageMapper
      def array_value(message_mapper, object)
        [
          hash_value(message_mapper, object)
        ]
      end
    end
  end
end