class ObjectPersonRoleFormBuilder < RdssFields
  def role_type(required: false)
    input :role_type, collection: ::Cdm::Selections::PersonRole.call, prompt: :translate, label: false, required: required
  end
end