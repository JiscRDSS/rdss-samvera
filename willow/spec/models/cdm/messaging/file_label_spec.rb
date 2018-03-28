require 'spec_helper'
class FileLabelDummy
  attr_reader :label

  def initialize()
    @label='12345'
  end
end

RSpec.describe ::Cdm::Messaging::FileLabel do
  let(:input_map) {
    { fileLabel: nil }
  }

  let(:expected_value) {
    { fileLabel: '12345' }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileLabelDummy.new)[:test]).to eql(expected_value)
    end
  end
end