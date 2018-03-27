require_relative 'facets'

class ObjectRightsFormBuilderDummy
  attr_accessor :licence, :rights_holder, :rights_statement

  def [](key)
    [key.to_s]
  end
end

RSpec.describe ObjectRightsFormBuilder do
  context 'licence' do
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectRightsFormBuilderDummy).licence, 'Licence', required: true
    it_behaves_like 'required', FacetsProxy.(described_class,ObjectRightsFormBuilderDummy).licence
    it_behaves_like 'optional', FacetsProxy.(described_class,ObjectRightsFormBuilderDummy).licence(required: false)
    it_behaves_like 'select',   FacetsProxy.(described_class,ObjectRightsFormBuilderDummy).licence, "https://creativecommons.org/licenses/by/4.0/", "Creative Commons Attribution License (CC BY 4.0)"
    it_behaves_like 'named',    FacetsProxy.(described_class,ObjectRightsFormBuilderDummy).licence, :licence, array: true
  end

  context 'rights_holder' do
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectRightsFormBuilderDummy).rights_holder, 'Rights holder', required: true
    it_behaves_like 'required', FacetsProxy.(described_class,ObjectRightsFormBuilderDummy).rights_holder
    it_behaves_like 'optional', FacetsProxy.(described_class,ObjectRightsFormBuilderDummy).rights_holder(required: false)
    it_behaves_like 'input',    FacetsProxy.(described_class,ObjectRightsFormBuilderDummy).rights_holder
    it_behaves_like 'named',    FacetsProxy.(described_class,ObjectRightsFormBuilderDummy).rights_holder, :rights_holder, array: true
  end

  context 'rights_statement' do
    it_behaves_like 'labelled',  FacetsProxy.(described_class,ObjectRightsFormBuilderDummy).rights_statement, 'Rights statement', required: true
    it_behaves_like 'required',  FacetsProxy.(described_class,ObjectRightsFormBuilderDummy).rights_statement
    it_behaves_like 'input',     FacetsProxy.(described_class,ObjectRightsFormBuilderDummy).rights_statement
    it_behaves_like 'named',     FacetsProxy.(described_class,ObjectRightsFormBuilderDummy).rights_statement, :rights_statement, array: true
  end
end