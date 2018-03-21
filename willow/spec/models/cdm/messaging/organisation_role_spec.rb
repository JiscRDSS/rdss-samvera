require 'spec_helper'
class OrganisationRoleDummy
  def organisation_role
    :funder
  end
end

RSpec.describe ::Cdm::Messaging::OrganisationRole do
  let(:input_map) {
    {
      organisationRole: nil
    }
  }

  let(:expected_value) {
    {
      organisationRole: 1
    }
  }

  describe 'decodes messaging sections' do
    it 'should have methods for the elements in the passed section' do
      expect(described_class.('test', input_map, OrganisationRoleDummy.new)[:test]).to eql(expected_value)
    end
  end
end