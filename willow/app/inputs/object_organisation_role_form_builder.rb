class ObjectOrganisationRoleFormBuilder < RdssFields
  def role(required: false)
    input :role,
          collection: ::Cdm::Selections::OrganisationRole.call,
          prompt: :translate,
          required: required
  end

  def organisation
    AssociationBuilder.(object, :organisation)
  end
end
