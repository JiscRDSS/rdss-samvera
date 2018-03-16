class ObjectOrganisationFormBuilder < RdssFields
  def jisc_id
    input :jisc_id
  end

  def name(required: true)
    input :name, required: required
  end

  def address(required: true)
    input :address, as: :text, required: required
  end

  def organisation_type(required: true)
    input :organisation_type,
          collection: ::Cdm::ObjectOrganisationTypesService.select_all_options,
          prompt: :translate,
          required: required
  end
end
