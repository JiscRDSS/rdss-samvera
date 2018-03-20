module Cdm
  class EnumerationsList
    class << self
      def call
        ::Enumerations::Decoder.sections
      end
    end
  end
end