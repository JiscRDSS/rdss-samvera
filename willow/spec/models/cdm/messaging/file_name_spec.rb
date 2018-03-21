require 'spec_helper'
class FileNameDummy
  attr_reader :file_name

  def initialize()
    @file_name=['test_file.pdf']
  end
end

RSpec.describe ::Cdm::Messaging::FileName do
  let(:input_map) {
    { fileName: nil }
  }

  let(:expected_value) {
    { fileName: 'test_file.pdf' }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileNameDummy.new)[:test]).to eql(expected_value)
    end
  end
end