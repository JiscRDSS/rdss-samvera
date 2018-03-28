require_relative 'facets'

class ObjectPersonRoleFormBuilderDummy
  attr_accessor :role_type
end

RSpec.describe ObjectPersonRoleFormBuilder do
  context 'role_type' do
    it_behaves_like 'unlabelled', FacetsProxy.(described_class,ObjectPersonRoleFormBuilderDummy).role_type, 'Role', required: false
    it_behaves_like 'optional',   FacetsProxy.(described_class,ObjectPersonRoleFormBuilderDummy).role_type
    it_behaves_like 'required',   FacetsProxy.(described_class,ObjectPersonRoleFormBuilderDummy).role_type(required: true)
    it_behaves_like 'select',     FacetsProxy.(described_class,ObjectPersonRoleFormBuilderDummy).role_type, 'author', 'Author'
    it_behaves_like 'named',      FacetsProxy.(described_class,ObjectPersonRoleFormBuilderDummy).role_type, :role_type
  end
end