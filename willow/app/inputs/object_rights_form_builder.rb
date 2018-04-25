class ObjectRightsFormBuilder < RdssFields
  def licence(required: true)
    input :licence, 
      as: :compact_multi_value_select,
      collection: Hyrax::LicenseService.new.select_active_options, 
      input_html: {
        prompt: I18n.t('simple_form.prompts.rdss_cdm.object_rights.licence')
      },
      required: required
  end

  def rights_holder(required: false)
    input :rights_holder, as: :compact_multi_value, required: required
  end

  def rights_statement(required: false)
    input :rights_statement, as: :compact_multi_value, required: required
  end

  def accesses
    object.accesses.build({access_type: 'open'}) if object.accesses.blank?
  end
end