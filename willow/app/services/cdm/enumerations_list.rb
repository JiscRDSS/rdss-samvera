module Cdm
  class EnumerationsList
    class << self
      def call
        ::Enumerations::DecoderFactory.sections
      end
    end
  end
end