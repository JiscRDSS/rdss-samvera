module Cdm
  module Messaging
    class RightsHolder < MessageMapper
      def array_value(_, object)
        object.rights_holder.to_a.select(&:presence)
      end
    end
  end
end