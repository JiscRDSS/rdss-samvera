class PersonIdentifiersAttributeRenderer
  include Concerns::CssTableRenderer

  def identifiers(value)
    value.person_identifiers
  end

  def attribute_value_to_html(value)
    table {
      tbody {
        identifiers(value).map do |identifier|
          row {
            cell { I18n.t("rdss.person_identifier_type.#{identifier.type}") } +
            cell { identifier.value }
          }
        end.join
      }
    }
  end
end