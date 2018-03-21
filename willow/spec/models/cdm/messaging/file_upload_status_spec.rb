require 'spec_helper'
class FileUploadStatusDummy
end

RSpec.describe ::Cdm::Messaging::FileUploadStatus do
  let(:input_map) {
    {
      fileUploadStatus: nil
    }
  }

  let(:expected_value) {
    {
      fileUploadStatus: 2
    }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileUploadStatusDummy.new)[:test]).to eql(expected_value)
    end
  end
end