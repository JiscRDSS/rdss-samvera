require_relative 'facets'

class RdssFieldsDummy
  attr_accessor :destroy
end

RSpec.describe RdssFields do
  context 'destroy' do
    it_behaves_like 'unlabelled', FacetsProxy.(described_class, RdssFieldsDummy).destroy
    it_behaves_like 'destroy', FacetsProxy.(described_class, RdssFieldsDummy).destroy
    it_behaves_like 'hidden',  FacetsProxy.(described_class, RdssFieldsDummy).destroy
    it_behaves_like 'named',  FacetsProxy.(described_class, RdssFieldsDummy).destroy, :_destroy
  end
end