class ObjectIdentifiersAttributeRenderer < Hyrax::Renderers::AttributeRenderer
  private
  include Concerns::CssTableRenderer

  def identifiers(value)
    json = [JSON.parse(value)].flatten # make sure we get an array, even if the json is just a single value
    json.map{|x| ::Cdm::Json::Identifier.new(x) unless x.empty?}.compact # reject any rows that are empty
  end

  def fake_minted_doi
    row {
      cell { I18n.t("rdss.identifier_type.doi") } +
      cell { CdmIdentifierRenderer.render_url('#','doi:10.1000/2342343') }
    }
  end

  def attribute_value_to_html(value)
    table {
      thead {
        row { header { "Type" } + header { "Value" } }
      } + 
      tbody {
        fake_minted_doi +
        identifiers(value).map do |identifier|
          row {
            cell { I18n.t("rdss.identifier_type.#{identifier.type}", default: identifier.type) } +
            cell { CdmIdentifierRenderer.(identifier.type, identifier.value) }
          }
        end.join
      }
    }
  end
end
