# Standard mapping for Person. Note this is hard called from the ObjectPersonRole as part of the override defined there.
module Cdm
  module Messaging
    class PersonOrganisation < EmptyMapper
      def hash_value(*)
        {
          organisationJiscId: 1,
          organisationName: 'not yet implemented',
          organisationType: 1,
          organisationAddress: 'not yet implemented'
        }
      end

      def array_value(*)
        [
          hash_value
        ]
      end
    end
  end
end
