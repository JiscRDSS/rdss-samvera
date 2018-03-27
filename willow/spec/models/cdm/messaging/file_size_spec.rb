require 'spec_helper'
class FileSizeDummy
  attr_reader :file_size

  def initialize()
    @file_size=['12345']
  end
end

RSpec.describe ::Cdm::Messaging::FileSize do
  let(:input_map) {
    { fileSize: nil }
  }

  let(:expected_value) {
    { fileSize: 12345 }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileSizeDummy.new)[:test]).to eql(expected_value)
    end
  end
end