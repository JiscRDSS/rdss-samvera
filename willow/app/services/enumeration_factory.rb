class EnumerationFactory < ClassifyFactory
  class << self
    def default_options
      {
        root: ::Cdm::Enumerations
      }
    end
  end
end