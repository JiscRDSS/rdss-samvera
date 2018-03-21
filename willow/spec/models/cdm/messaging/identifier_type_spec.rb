require 'spec_helper'
class IdentifierTypeDummy
  def identifier_type
    :isbn
  end
end

RSpec.describe ::Cdm::Messaging::IdentifierType do
  let(:input_map) {
    {
      identifierType: nil
    }
  }

  let(:expected_value) {
    {
      identifierType: 8
    }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, IdentifierTypeDummy.new)[:test]).to eql(expected_value)
    end
  end
end