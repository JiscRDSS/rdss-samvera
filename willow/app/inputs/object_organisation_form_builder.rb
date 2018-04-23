class ObjectOrganisationFormBuilder < RdssFields
  def jisc_id(required: false)
    input :jisc_id, required: required
  end

  def name(required: true)
    input :name, required: required
  end

  def address(required: true)
    input :address, as: :text, required: required
  end

  def organisation_type(required: true)
    input :organisation_type, as: :hidden, :input_html => { :value => "higher_education" }
  end
end
