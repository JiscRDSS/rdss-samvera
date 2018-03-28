require 'spec_helper'
class FileTechnicalAttributesDummy
end

RSpec.describe ::Cdm::Messaging::FileTechnicalAttributes do
  let(:input_map) {
    {
      fileTechnicalAttributes: nil
    }
  }

  let(:expected_value) {
    {
      fileTechnicalAttributes: ''
    }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileTechnicalAttributesDummy.new)[:test]).to eql(expected_value)
    end
  end
end