class ObjectPersonFormBuilder < RdssFields
  include Concerns::RelationArrayMapper

  def honorific_prefix
    input :honorific_prefix, required: object.required?(:honorific_prefix)
  end

  def given_name(required: true)
    input :given_name, required: required
  end

  def family_name(required: true)
    input :family_name, required: required
  end

  def destroy
    input :_destroy, as: :hidden, input_html:{ data: { destroy: true }, class: 'form-control remove-hidden', value: false}
  end

  def mail
    input :mail, as: :email, required: object.required?(:mail)
  end

  def object_person_roles
    build_if_blank(object.object_person_roles).to_a
  end
end