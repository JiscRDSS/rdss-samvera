class AssociationBuilder
  class << self
    def call(instance, association)
      instance.send("build_#{association}") if instance.send(association).blank?
      instance.send(association)
    end
  end
end