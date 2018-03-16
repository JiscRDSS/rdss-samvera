module RdssPersonRolesService
  class << self
    def select_all_options
      ::Cdm::Selections::PersonRole.call
    end

    def label(id)
      I18n.t("rdss.person_role.#{id}")
    end
  end
end
