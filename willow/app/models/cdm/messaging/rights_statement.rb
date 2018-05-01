module Cdm
  module Messaging
    class RightsStatement < MessageMapper
      def array_value(_, object)
        object.map(&:rights_statement)
      end
    end
  end
end