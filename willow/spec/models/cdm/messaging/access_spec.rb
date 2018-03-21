require 'spec_helper'
class DummyAccesses
  attr_reader :access_statement, :access_type
  def initialize(access_type: type, access_statement: statement)
    @access_type=access_type
    @access_statement=access_statement
  end
end

class AccessDummy
  def accesses
    [
      DummyAccesses.new(access_type: 'open', access_statement: nil),
      DummyAccesses.new(access_type: 'controlled', access_statement: 'wibble')
    ]
  end
end

RSpec.describe ::Cdm::Messaging::Access do
  describe 'decodes messaging sections' do
    let(:input_map) {
      {
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
        access: [
          {
            accessType: 1,
            accessStatement: 'Open'
          },
          {
            accessType: 3,
            accessStatement: 'wibble'
          }
        ]
      }
    }
    let(:test_object) { AccessDummy.new }
    let(:decoded_class) { described_class.('test', input_map, test_object)[:test] }

    it 'should have methods for the elements in the passed section' do
      expect(decoded_class).to eql(expected_value)
    end
  end
end