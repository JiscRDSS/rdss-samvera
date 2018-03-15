# Generated via
#  `rails generate hyrax:work RdssCdm`
module Hyrax
  module Actors
    class RdssCdmActor < Hyrax::Actors::BaseActor
      def default_values
        {
          object_value:   'normal',
          object_version: '1',
          object_uuid:    SecureRandom.uuid
        }
      end

      public
      def create(env)
        ::Rdss::Actors::SetAttributeValuesIfBlank.(env, default_values)
        super
      end
    end
  end
end
