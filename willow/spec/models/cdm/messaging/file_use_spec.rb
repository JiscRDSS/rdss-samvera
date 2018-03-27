require 'spec_helper'
class FileUseDummy
end

RSpec.describe ::Cdm::Messaging::FileUse do
  let(:input_map) {
    {
      fileUse: nil
    }
  }

  let(:expected_value) {
    {
      fileUse: 1
    }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileUseDummy.new)[:test]).to eql(expected_value)
    end
  end
end