require 'spec_helper'
class FileTechnicalAttributeDummy
end

RSpec.describe ::Cdm::Messaging::FileTechnicalAttribute do
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
      expect(described_class.('test', input_map, FileTechnicalAttributeDummy.new)[:test]).to eql(expected_value)
    end
  end
end