require 'spec_helper'
class FileRightsDummy
end

RSpec.describe ::Cdm::Messaging::FileRights do
  let(:input_map) {
    {
      rightsStatement: [ nil ],
      rightsHolder: [ nil ],
      licence: [
        {
          licenceName: nil,
          licenceIdentifier: nil
        }
      ],
      access: [
        {
          accessType: nil,
          accessStatement: nil
        }
      ]
    }
  }

  let(:expected_value) {
    {
      rightsStatement: [],
      rightsHolder: [],
      licence: [
        {
          licenceName: '',
          licenceIdentifier: ''
        }
      ],
      access: [
        {
          accessType: '',
          accessStatement: ''
        }
      ]
    }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileRightsDummy.new)[:test]).to eql(expected_value)
    end
  end
end