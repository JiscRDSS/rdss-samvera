module Hyrax
  module Core
    module RdssCdmFormFieldExtensions
      class << self
        def included(base)
          Junctions.activate(base, self.name)
        end
      end

      def terms
        [
          :title,
          :object_description,
          :object_keywords,
          :object_category,
          :object_resource_type,
          :object_value,
          :object_people,
          :object_dates,
          :object_rights,
          :object_organisation_roles,
          :object_identifiers,
          :object_related_identifiers,
        ]
      end

      def required
        [
          :title,
          :object_description,
          :object_resource_type,
          :object_value,
          :object_people,
          :object_dates,
          :object_rights,
          :object_organisation_roles,
          :object_identifiers,
        ]
      end
    end
  end
end
