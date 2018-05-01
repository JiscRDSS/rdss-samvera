module Cdm
  module Messaging
    class LicenceName < MessageMapper
      private
      def normalize(object)
        object.tr('^a-zA-Z0-9','_')
      end

      public
      def value(object, _)
        object.present? && I18n.t("rdss.licence.#{normalize(object)}") || ''
      end
    end
  end
end

