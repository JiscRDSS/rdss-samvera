# Endpoint for :personHonorificPrefix. This is mapped to :honorific_prefix in the internal metadata.

module Cdm
  module Messaging
    class PersonHonorificPrefix < MessageMapper
      include AttributeMapper
      attribute_name :honorific_prefix
    end
  end
end