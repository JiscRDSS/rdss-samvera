module Cdm
  module Json
    class PersonIdentifier < ::Cdm::Json::ModelBase
      attr_reader :type, :value
      def initialize(values={})
        @type=values['person_identifier_type']
        @value=values['person_identifier_value']
        super
      end
    end
  end
end