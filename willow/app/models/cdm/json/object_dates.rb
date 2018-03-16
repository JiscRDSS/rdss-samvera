module Cdm
  module Json
    class ObjectDates
      attr_reader :dates
      delegate :map, :"[]", to: :dates

      def initialize(string)
        @dates = JSON.parse(string).map { |x| ::Cdm::Json::ObjectDate.new(x) }
      end
    end
  end
end
