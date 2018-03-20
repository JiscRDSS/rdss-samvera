require 'spec_helper'

RSpec.describe ::Cdm::Json::ObjectOrganisationRoles do
  let(:values) do
    [{
      role: 'SomeRole',
      organisation: {
        jisc_id: 123
      }
    }].to_json
  end

  subject { described_class.new(values) }

  it 'has the correct type returned as a symbol' do
    expect(subject.map(&:role).first).to eq(:some_role)
  end

  describe 'organisation' do
    it 'is an instance of ObjectOrganisation' do
      expect(subject[0].organisation).to be_a(::Cdm::Json::Organisation)
    end
  end
end
