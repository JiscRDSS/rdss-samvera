# Standard mapping for Person. Note this is hard called from the ObjectPersonRole as part of the override defined there.
module Cdm
  module Messaging
    class PersonOrganisationUnit < EmptyMapper
      def hash_value(*)
        {
          organisation: {
            organisationJiscId: 1,
            organisationName: 'not yet implemented',
            organisationType: 1,
            organisationAddress: 'not yet implemented'
          },
          organisationUnitUuid: '00000000-0000-1000-a000-000000000000',
          organisationUnitName: 'not yet implemented'
        }
      end
    end
  end
end
