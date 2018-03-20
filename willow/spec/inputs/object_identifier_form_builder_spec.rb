require_relative 'facets'

class ObjectIdentifierFormBuilderDummy
  attr_accessor :identifier_type, :identifier_value
end

RSpec.describe ObjectIdentifierFormBuilder do
  context 'identifier_type' do
    it_behaves_like 'unlabelled',    FacetsProxy.(described_class,ObjectIdentifierFormBuilderDummy).identifier_type
    it_behaves_like 'optional',    FacetsProxy.(described_class,ObjectIdentifierFormBuilderDummy).identifier_type
    it_behaves_like 'selected', FacetsProxy.(described_class,ObjectIdentifierFormBuilderDummy).identifier_type, 'isbn', 'ISBN'
    it_behaves_like 'named',    FacetsProxy.(described_class,ObjectIdentifierFormBuilderDummy).identifier_type, :identifier_type
  end

  context 'identifier_value' do
    it_behaves_like 'unlabelled',    FacetsProxy.(described_class,ObjectIdentifierFormBuilderDummy).identifier_value
    it_behaves_like 'optional',    FacetsProxy.(described_class,ObjectIdentifierFormBuilderDummy).identifier_value
    it_behaves_like 'input',    FacetsProxy.(described_class,ObjectIdentifierFormBuilderDummy).identifier_value
    it_behaves_like 'named',    FacetsProxy.(described_class,ObjectIdentifierFormBuilderDummy).identifier_value, :identifier_value
  end
end