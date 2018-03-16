module Cdm
  class RelationTypesService < ServicesBase
    class << self
      def authority_name
        'rdss_relation_types'
      end

      def internationalisation_root
        'rdss.relation_type.'
      end
    end
  end
end