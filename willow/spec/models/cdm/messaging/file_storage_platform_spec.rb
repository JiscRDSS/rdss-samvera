require 'spec_helper'
class FileStoragePlatformDummy
end

RSpec.describe ::Cdm::Messaging::FileStoragePlatform do
  let(:input_map) {
    {
      storagePlatformUuid: nil,
      storagePlatformName: nil,
      storagePlatformType: nil,
      storagePlatformCost: nil
    }
  }

  let(:expected_value) {
    {
      storagePlatformUuid: '00000000-0000-1000-a000-000000000000',
      storagePlatformName: 'not yet implemented',
      storagePlatformType: 2,
      storagePlatformCost: 'not yet implemented'
    }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileStoragePlatformDummy.new)[:test]).to eql(expected_value)
    end
  end
end