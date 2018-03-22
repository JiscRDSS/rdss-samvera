require 'spec_helper'
class FileFormatTypeDummy
  attr_reader :format_label

  def initialize()
    @format_label=[12345]
  end
end

RSpec.describe ::Cdm::Messaging::FileFormatType do
  let(:input_map) {
    { fileFormatType: nil }
  }

  let(:expected_value) {
    { fileFormatType: 12345 }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileFormatTypeDummy.new)[:test]).to eql(expected_value)
    end
  end
end