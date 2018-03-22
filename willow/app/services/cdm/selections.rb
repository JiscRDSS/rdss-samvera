# The list of enumerated types as selections. Note that this could have been automatically generated from the source file
# config/schemas/enumerations.json, but that would have tied us to the file at this level and the preference
# would be to move to an API call into the Taxonomy system at some point.

module Cdm
  module Selections
    ::Cdm::EnumerationsList.().each do |enum_section|
      ::Cdm::Selections::const_set(enum_section.classify, ::Selections::Decoder.(enum_section, { namespace: ::Cdm::Enumerations }))
    end
  end
end