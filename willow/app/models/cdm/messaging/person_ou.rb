# Standard mapping for Person. Note this is hard called from the ObjectPersonRole as part of the override defined there.
module Cdm
  module Messaging
    class PersonOu < EmptyMapper
      def value(object, *)
        'not yet implemented'
      end
    end
  end
end
