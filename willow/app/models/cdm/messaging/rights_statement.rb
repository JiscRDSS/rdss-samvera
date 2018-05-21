module Cdm
  module Messaging
    class RightsStatement < MessageMapper
      def array_value(_, object)
        object.rights_statement.map(&:presence).compact.presence || ['forced for message completeness']
      end
    end
  end
end