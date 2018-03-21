require 'spec_helper'
class FileStorageLocationDummy
  attr_reader :file_storage_location
end

RSpec.describe ::Cdm::Messaging::FileStorageLocation do
  let(:input_map) {
    { fileStorageLocation: nil }
  }

  let(:expected_value) {
    { fileStorageLocation: Hyrax::Engine.routes.url_helpers.download_url(FileStorageLocationDummy.new, host: (ENV['SAMVERA_INTERNAL_HOST'] || Rails.application.routes.default_url_options[:host])).rpartition(':').first }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileStorageLocationDummy.new)[:test][:fileStorageLocation].rpartition(':').first).to eql(expected_value[:fileStorageLocation])
    end
  end
end