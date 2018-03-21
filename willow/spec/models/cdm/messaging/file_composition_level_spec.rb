require 'spec_helper'
class FileCompositionLevelDummy
  attr_reader :compression

  def initialize()
    @compression=[12345]
  end
end

RSpec.describe ::Cdm::Messaging::FileCompositionLevel do
  let(:input_map) {
    { fileCompositionLevel: nil }
  }

  let(:expected_value) {
    { fileCompositionLevel: '12345' }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileCompositionLevelDummy.new)[:test]).to eql(expected_value)
    end
  end
end