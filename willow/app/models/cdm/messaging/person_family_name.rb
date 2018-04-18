# Endpoint for :personFamilyNames. This is mapped to :family_name in the CDM internal model.

module Cdm
  module Messaging
    class PersonFamilyName < MessageMapper
      include AttributeMapper
      attribute_name :family_name
    end
  end
end