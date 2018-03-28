require 'spec_helper'
class FileIdentifierDummy
  attr_reader :id

  def initialize()
    @id=12345
  end
end

RSpec.describe ::Cdm::Messaging::FileIdentifier do
  let(:input_map) {
    { fileIdentifier: nil }
  }

  let(:expected_value) {
    { fileIdentifier: 12345 }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileIdentifierDummy.new)[:test]).to eql(expected_value)
    end
  end
end