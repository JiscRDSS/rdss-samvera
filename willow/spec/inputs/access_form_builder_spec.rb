require_relative 'facets'

class AccessFormBuilderDummy
  attr_accessor :access_type, :access_statement
end

RSpec.describe AccessFormBuilder do
  context 'access_type' do
    it_behaves_like 'labelled', FacetsProxy.(described_class, AccessFormBuilderDummy).access_type, 'Access type', required: true
    it_behaves_like 'required', FacetsProxy.(described_class, AccessFormBuilderDummy).access_type
    it_behaves_like 'optional', FacetsProxy.(described_class, AccessFormBuilderDummy).access_type(required: false)
    it_behaves_like 'select',   FacetsProxy.(described_class, AccessFormBuilderDummy).access_type, 'open', 'Open'
    it_behaves_like 'named',    FacetsProxy.(described_class, AccessFormBuilderDummy).access_type, :access_type
  end

  context 'access_statement' do
    it_behaves_like 'labelled', FacetsProxy.(described_class, AccessFormBuilderDummy).access_statement, 'Access statement', required: true
    it_behaves_like 'required', FacetsProxy.(described_class, AccessFormBuilderDummy).access_statement
    it_behaves_like 'optional', FacetsProxy.(described_class, AccessFormBuilderDummy).access_statement(required: false)
    it_behaves_like 'input',    FacetsProxy.(described_class, AccessFormBuilderDummy).access_statement
    it_behaves_like 'named',    FacetsProxy.(described_class, AccessFormBuilderDummy).access_statement, :access_statement
  end
end