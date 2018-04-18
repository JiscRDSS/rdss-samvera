# Endpoint for :personHonorificSuffix. This is mapped to :honorific_suffix in the internal metadata.

module Cdm
  module Messaging
    class PersonHonorificSuffix < MessageMapper
      include AttributeMapper
      attribute_name :honorific_suffix
    end
  end
end