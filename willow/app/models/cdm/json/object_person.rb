module Cdm
  module Json
    class ObjectPerson < ::Cdm::Json::ModelBase
      attr_reader :honorific_prefix, :given_name, :family_name, :honorific_suffix, :mail, :roles
      def initialize(values={}, converter=::Cdm::Json::ObjectPersonRole)
        @honorific_prefix=values['honorific_prefix']
        @given_name=values['given_name']
        @family_name=values['family_name']
        @honorific_suffix=values['honorific_prefix']
        @mail=values['mail']
        @roles=values['object_person_roles'].map {|x| converter.new(x) }
        super(values)
      end

      def name
        [honorific_prefix, given_name, family_name, honorific_suffix].join(' ').squish
      end
    end
  end
end