module Cdm
  class LicenceService < ServicesBase
    class << self
      def authority_name
        'licences'
      end

      def internationalisation_root
        'rdss.licence.'
      end
    end
  end
end