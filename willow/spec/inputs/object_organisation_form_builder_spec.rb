require_relative 'facets'

class ObjectOrganisationFormBuilderDummy
  attr_accessor :jisc_id, :name, :address, :organisation_type
end

RSpec.describe ObjectOrganisationFormBuilder do
  context 'jisc_id' do
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).jisc_id, 'Identifier'
    it_behaves_like 'optional', FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).jisc_id
    it_behaves_like 'required', FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).jisc_id(required: true)
    it_behaves_like 'numeric',  FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).jisc_id
    it_behaves_like 'named',    FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).jisc_id, :jisc_id
  end

  context 'name' do
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).name, 'Name', required: true
    it_behaves_like 'required', FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).name
    it_behaves_like 'optional', FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).name(required: false)
    it_behaves_like 'input',    FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).name
    it_behaves_like 'named',    FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).name, :name
  end

  context 'address' do
    it_behaves_like 'labelled',  FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).address, 'Address', required: true
    it_behaves_like 'required',  FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).address
    it_behaves_like 'optional',  FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).address(required: false)
    it_behaves_like 'text_area', FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).address
    it_behaves_like 'named',     FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).address, :address
  end

  context 'organisation_type' do
    it_behaves_like 'hidden', FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).organisation_type
    it_behaves_like 'named',    FacetsProxy.(described_class,ObjectOrganisationFormBuilderDummy).organisation_type, :organisation_type
  end
end
