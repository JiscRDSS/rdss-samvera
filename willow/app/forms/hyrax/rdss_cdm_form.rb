# Generated via
#  `rails generate hyrax:work RdssCdm`
module Hyrax
  class RdssCdmForm < Hyrax::Forms::WorkForm
    self.model_class = ::RdssCdm

    self.terms = [
      :title,
      :object_description,
      :object_keywords,
      :object_category,
      :object_version,
      :object_date
    ]
    self.required_fields = [
      :title
    ]

    # Permitted parameters for nested attributes
    # These need to define the incoming parameters for any nested form attributes so that
    # strong_params permits them
    def self.permitted_object_date_params
      [:id,
       :_destroy,
       {
         date_value: [],
         date_type: []
       }]
    end

    def self.build_permitted_params
      permitted = super
      # add in object_date attributes
      permitted << { object_date_attributes: permitted_object_date_params }
      permitted
    end
  end
end
