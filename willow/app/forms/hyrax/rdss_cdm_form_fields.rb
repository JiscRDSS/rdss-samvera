module Hyrax
  class RdssCdmFormFields
    include Core::RdssCdmFormFieldExtensions

    class << self
      def required
        new.required
      end

      def terms
        new.terms
      end
    end
  end
end