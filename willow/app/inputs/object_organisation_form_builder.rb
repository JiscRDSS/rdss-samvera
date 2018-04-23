class ObjectOrganisationFormBuilder < RdssFields
  def jisc_id(required: false)
    input :jisc_id, as: :integer, required: required
  end

  def name(required: true)
    input :name, required: required
  end

  def address(required: true)
    input :address, as: :hidden, :input_html => { :value => "A default address" }
  end

  def organisation_type(required: true)
    input :organisation_type, as: :hidden, :input_html => { :value => "higher_education" }
  end
end
