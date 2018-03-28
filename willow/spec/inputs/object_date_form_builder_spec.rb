require_relative 'facets'

class ObjectDateFormBuilderDummy
  attr_accessor :date_type, :date_value
end

RSpec.describe ObjectDateFormBuilder do
  context 'date_type' do
    it_behaves_like 'unlabelled', FacetsProxy.(described_class,ObjectDateFormBuilderDummy).date_type
    it_behaves_like 'optional',   FacetsProxy.(described_class,ObjectDateFormBuilderDummy).date_type
    it_behaves_like 'required',   FacetsProxy.(described_class,ObjectDateFormBuilderDummy).date_type(required: true)
    it_behaves_like 'select',     FacetsProxy.(described_class,ObjectDateFormBuilderDummy).date_type, 'available', 'Available'
    it_behaves_like 'named',      FacetsProxy.(described_class,ObjectDateFormBuilderDummy).date_type, :date_type
  end

  context 'date_value' do
    it_behaves_like 'unlabelled', FacetsProxy.(described_class,ObjectDateFormBuilderDummy).date_value
    it_behaves_like 'optional',   FacetsProxy.(described_class,ObjectDateFormBuilderDummy).date_value
    it_behaves_like 'required',   FacetsProxy.(described_class,ObjectDateFormBuilderDummy).date_value(required: true)
    it_behaves_like 'input',      FacetsProxy.(described_class,ObjectDateFormBuilderDummy).date_value
    it_behaves_like 'named',      FacetsProxy.(described_class,ObjectDateFormBuilderDummy).date_value, :date_value
  end
end