class ObjectOrganisationRoleFormBuilder < RdssFields
  def role(required: false)
    input :role,
          collection: ::Cdm::Selections::OrganisationRole.call,
          prompt: :translate,
          required: required
  end

  def organisation
    object.build_organisation if object.organisation.blank?
    object.organisation
  end
end
