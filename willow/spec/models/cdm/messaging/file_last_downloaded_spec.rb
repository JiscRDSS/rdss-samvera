require 'spec_helper'
class FileLastDownloadedDummy
  attr_reader :date_modified

  def initialize()
    @date_modified=Time.at(100)
  end
end

RSpec.describe ::Cdm::Messaging::FileLastDownloaded do
  let(:input_map) {
    [
      {
        dateType: nil,
        dateValue: nil
      }
    ]
  }

  let(:expected_value) {
    [
      {
        dateType: 7,
        dateValue: '1970-01-01T00:01:40+00:00'
      }
    ]
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileLastDownloadedDummy.new)[:test]).to eql(expected_value)
    end
  end
end