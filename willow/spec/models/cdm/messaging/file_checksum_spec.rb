require 'spec_helper'
class FileChecksumDummy
  attr_reader :checksum_uuid, :original_file, :original_checksum

  def initialize()
    @checksum_uuid=10000
    @original_file=self
    @original_checksum=[12345]
  end
end

RSpec.describe ::Cdm::Messaging::FileChecksum do
  let(:file_checksum_map) {
    [
      {
        checksumUuid: nil,
        checksumType: nil,
        checksumValue: nil
      }
    ]
  }

  let(:expected_value) {
    [
      {
        checksumUuid: 10000,
        checksumType: 1,
        checksumValue: 12345
      }
    ]
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', file_checksum_map, FileChecksumDummy.new)[:test]).to eql(expected_value)
    end
  end
end