require 'spec_helper'
class FileHasMimeTypeDummy
  attr_reader :mime_type

  def initialize()
    @mime_type='application/pdf'
  end
end

RSpec.describe ::Cdm::Messaging::FileHasMimeType do
  let(:input_map) {
    { fileHasMimeType: nil }
  }

  let(:expected_value) {
    { fileHasMimeType: true }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileHasMimeTypeDummy.new)[:test]).to eql(expected_value)
    end
  end
end