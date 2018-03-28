require 'spec_helper'
class AccessStatementDummy
  attr_reader :access_statement, :access_type

  def initialize(access_statement: nil)
    @access_statement=access_statement
    @access_type='open'
  end
end

RSpec.describe ::Cdm::Messaging::AccessStatement do
  describe 'decodes messaging sections' do
    let(:input_map) {
      { accessStatement: nil }
    }

    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, AccessStatementDummy.new(access_statement: 'passed in statement'))[:test]).to eql(accessStatement: 'passed in statement')
    end

    it 'should default to the string representation of access_type if access_statement is missing' do
      expect(described_class.('test', input_map, AccessStatementDummy.new)[:test]).to eql(accessStatement: 'Open')
    end
  end
end