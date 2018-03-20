require_relative 'facets'

class ObjectRelatedIdentifierFormBuilderDummy
  attr_accessor :relation_type
end

RSpec.describe ObjectRelatedIdentifierFormBuilder do
  context 'relation_type' do
    it_behaves_like 'unlabelled', FacetsProxy.(described_class,ObjectRelatedIdentifierFormBuilderDummy).relation_type
    it_behaves_like 'optional',   FacetsProxy.(described_class,ObjectRelatedIdentifierFormBuilderDummy).relation_type
    it_behaves_like 'required',   FacetsProxy.(described_class,ObjectRelatedIdentifierFormBuilderDummy).relation_type(required: true)
    it_behaves_like 'select', FacetsProxy.(described_class,ObjectRelatedIdentifierFormBuilderDummy).relation_type, 'is_based_on', 'Is based on'
    it_behaves_like 'named', FacetsProxy.(described_class,ObjectRelatedIdentifierFormBuilderDummy).relation_type, :relation_type
  end
end