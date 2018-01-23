class NestedOrganisationAttributeRenderer < Hyrax::Renderers::FacetedAttributeRenderer
  private
  def li_value(value)
    value = JSON.parse(value)
    html = []
    value.each do |v|
      organisation = []
      if v.include?('name') and not v['name'][0].blank?
        organisation << link_to(ERB::Util.h(v['name'][0]), search_path(v['name'][0]))
      end
      if v.include?('role') and not v['role'].blank? and not v['role'][0].blank?
        organisation << "Role: #{v['role'][0]}"
      end
      html << organisation.join('<br>')
    end
    html = html.join('<br/><br/>')
    %(#{html})
  end
end
