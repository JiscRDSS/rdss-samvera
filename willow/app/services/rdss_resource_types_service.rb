module RdssResourceTypesService
  class << self
    def select_all_options
      ::Cdm::Selections::ResourceType.call
    end

    def label(id)
      I18n.t("rdss.resource_type.#{id}")
    end
  end
end
