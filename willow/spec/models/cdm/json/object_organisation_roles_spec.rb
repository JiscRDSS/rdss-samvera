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

  it 'has the correct type returned as a string' do
    expect(subject.map(&:type).first).to eq("Accepted")
  end

  it 'has a date returned as value' do
    expect(subject[0].value).to eq("01/01/1970")
  end
end
