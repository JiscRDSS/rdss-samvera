module Cdm
  class AccessTypesService < ServicesBase
    class << self
      def authority_name
        'rdss_access_types'
      end

      def internationalisation_root
        'rdss.access_type.'
      end
    end
  end
end