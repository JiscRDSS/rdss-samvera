require 'spec_helper'
class EmptyMapperDummy
end

RSpec.describe ::Cdm::Messaging::EmptyMapper do
  let(:array_map) {
    [
    ]
  }

  let(:hash_map) {
    {
    }
  }

  let(:value_map) {
    nil
  }


  let(:expected_value) {
    ''
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', array_map, EmptyMapperDummy.new)[:test]).to eql(nil)
      expect(described_class.('test', hash_map, EmptyMapperDummy.new)[:test]).to eql(nil)
      expect(described_class.('test', value_map, EmptyMapperDummy.new)[:test]).to eql(nil)
    end
  end
end