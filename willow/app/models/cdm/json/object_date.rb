module Cdm
  module Json
    class ObjectDate < ::Cdm::Json::ModelBase
      attr_reader :type, :value
      def initialize(values={}, converter=::Cdm::Json::ObjectPersonRole)
        @type=I18n.t("rdss.date_type.#{Enumerations::DateType.send(values['date_type'])}")
        @value=Date.parse(values['date_value']).to_formatted_s(:standard)
      end
    end
  end
end