module Cdm
  module Messaging
    class PersonUuid < MessageMapper
      include AttributeMapper
      attribute_name :id
    end
  end
end