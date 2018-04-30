module Cdm
  module Json
    class ObjectPerson < ::Cdm::Json::ModelBase

      attr_reader :honorific_prefix, :given_name, :family_name, :honorific_suffix, :mail, :roles, :person_identifiers
      def initialize(values={}, converter=::Cdm::Json::ObjectPersonRole, person_identifiers_converter=::Cdm::Json::PersonIdentifier)
        @honorific_prefix=values['honorific_prefix']
        @given_name=values['given_name']
        @family_name=values['family_name']
        @honorific_suffix=values['honorific_suffix']
        @mail=values['mail']
        @roles=values['object_person_roles'].map {|x| converter.new(x) }
        @person_identifiers=values['person_identifiers'].map { |x| person_identifiers_converter.new(x) }
        super(values)
      end

      def name
        [honorific_prefix, given_name, family_name, honorific_suffix].join(' ').squish
      end
    end
  end
end