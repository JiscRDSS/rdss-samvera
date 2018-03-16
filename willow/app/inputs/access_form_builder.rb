class AccessFormBuilder < RdssFields
  def access_type(required: true)
    input :access_type, collection: Cdm::Selections::AccessType.call, prompt: :translate, required: required
  end

  def access_statement
    input :access_statement
  end
end