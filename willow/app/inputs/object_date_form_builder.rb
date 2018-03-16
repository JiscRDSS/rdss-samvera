class ObjectDateFormBuilder < RdssFields
  def date_type(required: false)
    input :date_type, collection: ::Cdm::Selections::DateType.call, prompt: :translate, label: false, required: required
  end

  def date_value(required: false)
    input :date_value, label: false, required: required, input_html: {data: { provide: 'datepicker' }}
  end
end