class PersonIdentifierFormBuilder < RdssFields
  def person_identifier_type(required: false)
    input :person_identifier_type, collection: ::Cdm::Selections::PersonIdentifierType.call, prompt: :translate, label: false, required: required
  end

  def person_identifier_value(required: false)
    input :person_identifier_value, label: false, required: required
  end
end