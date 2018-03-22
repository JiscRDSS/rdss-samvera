require 'spec_helper'
class FileDateCreatedDummy
  attr_reader :original_file, :date_created

  def initialize()
    @original_file=self
    @date_created=[Time.at(0)]
  end
end

RSpec.describe ::Cdm::Messaging::FileDateCreated do
  let(:input_map) {
    {
      dateType: nil,
      dateValue: nil
    }
  }

  let(:expected_value) {
    {
      dateType: 6,
      dateValue: '1970-01-01T00:00:00+00:00'
    }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, FileDateCreatedDummy.new)[:test]).to eql(expected_value)
    end
  end
end