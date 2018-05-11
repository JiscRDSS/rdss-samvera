require 'spec_helper'

RSpec.describe ::Cdm::Json::PersonIdentifier do
  let(:values) do
    {
      person_identifier_type: 'twitter',
      person_identifier_value: '@POTUS'
    }.to_json
  end

  subject { described_class.new(JSON.parse(values)) }

  it 'has the correct type' do
    expect(subject.type).to eq('twitter')
  end

  it 'has the correct value' do
    expect(subject.value).to eq('@POTUS')
  end
end
