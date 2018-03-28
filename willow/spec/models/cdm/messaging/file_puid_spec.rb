require 'spec_helper'
class FilePuidDummy
  def file_puid
    []
  end
end

RSpec.describe ::Cdm::Messaging::FilePuid do
  let(:input_map) {
    { filePuid: [ nil ] }
  }

  let(:expected_value) {
    { filePuid: [] }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FilePuidDummy.new)[:test]).to eql(expected_value)
    end
  end
end