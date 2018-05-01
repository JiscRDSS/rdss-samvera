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
    nil
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileRightDummy.new)[:test]).to eql(expected_value)
    end
  end
end
