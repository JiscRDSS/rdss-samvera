require 'spec_helper'
class FileRightDummy
end

RSpec.describe ::Cdm::Messaging::FileRight do
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
      rightsStatement: ['not yet implemented'],
      rightsHolder: ['not yet implemented'],
      licence: [
        {
          licenceName: 'not yet implemented',
          licenceIdentifier: 'not yet implemented'
        }
      ],
      access: [
        {
          accessType: 3,
          accessStatement: 'not yet implemented'
        }
      ]
    }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileRightDummy.new)[:test]).to eql(expected_value)
    end
  end
end
