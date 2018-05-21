module Cdm
  module Messaging
    class RightsHolder < MessageMapper
      def array_value(_, object)
        object.rights_holder.map(&:presence).compact.presence || ['forced for message completeness']
      end
    end
  end
end