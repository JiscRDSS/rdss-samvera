module RdssDateTypesService
  class << self
    def select_all_options
      ::Cdm::Selections::DateType.call
    end

    def label(id)
      I18n.t("rdss.date_type.#{id}")
    end
  end
end
