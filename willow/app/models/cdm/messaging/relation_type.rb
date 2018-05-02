# TODO: The messaging format and CDM don't quite match or make perfect sense for ObjectIdentifier and ObjectRelatedIdentifier
# The standard hashing is overridden to force a valid relation_type in here, even though it shouldn't be required for ObjectIdentifier
# and the hash_value method should be removed when the correct messaging map is applied.
module Cdm
  module Messaging
    class RelationType < EnumerationMapper
    end
  end
end