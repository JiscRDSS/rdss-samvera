require 'spec_helper'
class FileStorageTypeDummy
end

RSpec.describe ::Cdm::Messaging::FileStorageType do
  let(:input_map) {
    {
      fileStorageType: nil
    }
  }

  let(:expected_value) {
    {
      fileStorageType: 2
    }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileStorageTypeDummy.new)[:test]).to eql(expected_value)
    end
  end
end
