require 'rails_helper'
require_relative('core/messaging_attributes_extensions')
$: << File.expand_path(File.join(__dir__))
class MessagingAttributes
  include Core::MessagingAttributesExtensions
end

RSpec.describe ::Cdm::Messaging::RdssCdm do
  describe 'generates a message body with a passed CDM object' do
    let(:attributes) { ::MessagingAttributes.new.request_attributes }
    let(:final_body) { ::MessagingAttributes.new.result_attributes }
    let(:cdm_object) { ::RdssCdm.new(attributes) }

    it 'should generate a message body hash as the payload' do
      VCR.use_cassette('rdss_cdm_messaging', match_requests_on: [:method, :host]) do
        expect(described_class.(cdm_object)).to eq(final_body)
      end
    end
  end
end
