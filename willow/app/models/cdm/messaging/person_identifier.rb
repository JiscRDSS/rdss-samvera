# Standard mapping for Person. Note this is hard called from the ObjectPersonRole as part of the override defined there.
module Cdm
  module Messaging
    class PersonIdentifier < MessageMapper
      include AttributeMapper
      attribute_name :person_identifiers
    end
  end
end