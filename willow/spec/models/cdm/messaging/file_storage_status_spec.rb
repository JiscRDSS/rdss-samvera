require 'spec_helper'
class FileStorageStatusDummy
end

RSpec.describe ::Cdm::Messaging::FileStorageStatus do
  let(:input_map) {
    {
      fileStorageStatus: nil
    }
  }

  let(:expected_value) {
    {
      fileStorageStatus: 1
    }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileStorageStatusDummy.new)[:test]).to eql(expected_value)
    end
  end
end