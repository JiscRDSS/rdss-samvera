module Cdm
  class DoiRenderer < StringRenderer
    class << self
      def call(value)
        url, display = DoiNormaliser.(value)
        UriRenderer.(display, url)
      end
    end
  end
end
