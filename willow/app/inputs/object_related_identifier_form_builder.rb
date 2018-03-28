class ObjectRelatedIdentifierFormBuilder < RdssFields
  def relation_type(required: false)
    input :relation_type, collection: ::Cdm::Selections::RelationType.call, prompt: :translate, label: false, required: required
  end

  def identifier
    AssociationBuilder.(object, :identifier)
  end
end