class ObjectOrganisationRoleFormBuilder < RdssFields
  def role(required: false)
    input :role, collection: ::Cdm::ObjectOrganisationRolesService.select_all_options, prompt: :translate, label: false, required: required
  end
end