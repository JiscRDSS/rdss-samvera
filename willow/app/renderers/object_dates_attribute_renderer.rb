class ObjectDatesAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  include Concerns::CssTableRenderer

  def identifiers(value)
    ::Cdm::Json::ObjectDates.new(value)
  end

  # translate the json string for object date into a table of displayable dates
  # parse the json, and create a table where each row has a cell with the date type and the date value
  def attribute_value_to_html(value)
    table {
      thead {
        row { header { "Type" } + header { "Value" } }
      } +
      tbody {
        identifiers(value).map do |identifier|
          row {
            cell { identifier.type } +
            cell { identifier.value }
          }
        end.join
      }
    }
  end
end