require 'spec_helper'
class FilePreservationEventDummy
end

RSpec.describe ::Cdm::Messaging::FilePreservationEvent do
  let(:input_map) {
    [
      {
        preservationEventValue: nil,
        preservationEventType: nil,
        preservationEventDetail: nil
      }
    ]
  }

  let(:expected_value) {
    [
      {
        preservationEventValue: 'not yet implemented',
        preservationEventType: 3,
        preservationEventDetail: 'not yet implemented'
      }
    ]
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FilePreservationEventDummy.new)[:test]).to eql(expected_value)
    end
  end
end