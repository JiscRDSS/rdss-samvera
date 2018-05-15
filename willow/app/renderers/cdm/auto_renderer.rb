module Cdm
  class AutoRenderer < StringRenderer
    class << self
      def call(value)
        value.to_s.is_valid_uri? ? Cdm::UriRenderer.(value) : super
      end
    end
  end
end
