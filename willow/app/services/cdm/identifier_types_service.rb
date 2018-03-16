module Cdm
  class IdentifierTypesService < ServicesBase
    class << self
      def authority_name
        'rdss_identifier_types'
      end

      def internationalisation_root
        'rdss.identifier_type.'
      end
    end
  end
end