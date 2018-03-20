require_relative 'facets'

class ObjectOrganisationRoleFormBuilderDummy
  attr_accessor :role
end

RSpec.describe ObjectOrganisationRoleFormBuilder do
  context 'role' do
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectOrganisationRoleFormBuilderDummy).role, 'Role'
    it_behaves_like 'optional', FacetsProxy.(described_class,ObjectOrganisationRoleFormBuilderDummy).role
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectOrganisationRoleFormBuilderDummy).role(required: true), 'Role', required: true
    it_behaves_like 'required', FacetsProxy.(described_class,ObjectOrganisationRoleFormBuilderDummy).role(required: true)
    it_behaves_like 'select',   FacetsProxy.(described_class,ObjectOrganisationRoleFormBuilderDummy).role, 'distributor', 'Distributor'
    it_behaves_like 'named',    FacetsProxy.(described_class,ObjectOrganisationRoleFormBuilderDummy).role, :role
  end
end