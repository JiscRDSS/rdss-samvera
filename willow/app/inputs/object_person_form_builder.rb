class ObjectPersonFormBuilder < RdssFields
  include Concerns::RelationArrayMapper

  def honorific_prefix(required: false)
    input :honorific_prefix, required: required
  end

  def given_name(required: true)
    input :given_name, required: required
  end

  def family_name(required: true)
    input :family_name, required: required
  end

  def mail(required: true)
    input :mail, as: :email, required: required
  end

  def object_person_roles
    build_if_blank(object.object_person_roles).to_a
  end
end