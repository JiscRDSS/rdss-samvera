class ObjectIdentifierFormBuilder < RdssFields
  def identifier_type(required: false)
    input :identifier_type, collection: ::Cdm::Selections::IdentifierType.call, prompt: :translate, label: false, required: required
  end

  def identifier_value(required: false)
    input :identifier_value, label: false, required: required
  end
end