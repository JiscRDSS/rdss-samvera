module Hyrax
  module CdmDemo
    module RdssCdmFormFieldExtensions
      def terms
        [
          :title,
          :metadata_only,
          :object_description,
          :object_keywords,
          :object_category,
          :object_resource_type,
          :object_identifiers,
          :object_value,
          :object_people,
          :object_dates,
          :object_rights,
          :object_organisation_roles,
          :object_related_identifiers,
        ]
      end

      def required
        [
          :title,
          :metadata_only,
          :object_description,
          :object_resource_type,
          :object_identifiers,
          :object_value,
          :object_people,
          :object_dates,
          :object_rights,
          :object_organisation_roles,
        ]
      end
    end
  end
end
