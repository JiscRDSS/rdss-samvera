# Generated via
#  `rails generate hyrax:work RdssCdm`
module Hyrax
  class RdssCdmPresenter < Hyrax::WorkShowPresenter
    delegate :title, :object_description, :object_keywords, :object_category, to: :solr_document
    
    # translate the json string for object date into a displayable value
    # This goes through the json values and for each one produces a string of the form
    # "<date_type>: <date_value"
    # E.G "Created: 20/10/2018"
    def object_date
      values = []
      date = solr_document.object_date.try(:first)
      if date
        date_json = JSON.parse date
        date_json.each do |date|
          type = date['date_type'].try(:first)
          value = date['date_value'].try(:first)
          values << "#{type.humanize}: #{value}" unless(type.blank? || value.blank?)
        end
      end
      values
    end
  end
end
