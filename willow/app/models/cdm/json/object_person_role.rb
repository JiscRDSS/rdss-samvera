module Cdm
  module Json
    class ObjectPersonRole < ::Cdm::Json::ModelBase
      attr_reader :role_type
      def initialize(values={})
        @role_type=values['role_type'].underscore.downcase.intern
        super
      end

      def name
        I18n.t("rdss.person_role.#{role_type}")
      end
    end
  end
end
