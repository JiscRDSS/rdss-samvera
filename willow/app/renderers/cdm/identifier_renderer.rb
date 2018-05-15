module Cdm
  class IdentifierRenderer < TypeRenderer
    class << self
      def default_mappings
        {
          doi: Cdm::DoiRenderer,
          url: Cdm::UriRenderer
        }
      end
    end
  end
end