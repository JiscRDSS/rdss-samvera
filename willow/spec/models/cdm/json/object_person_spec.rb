require 'spec_helper'

RSpec.describe ::Cdm::Json::ObjectPerson do
  let(:values) do
    {
      honorific_prefix: 'Mr.',
      given_name: 'Paul',
      family_name: 'Mak',
      mail: 'pmak@example.com',
      object_person_roles: [{role_type: 'author'}, {role_type: 'editor'}],
      person_identifiers: []
    }.to_json
  end

  subject { described_class.new(JSON.parse(values)) }

  it 'has honorific_prefix as the supplied string' do
    expect(subject.honorific_prefix).to eq('Mr.')
  end

  it 'has given_name as the supplied string' do
    expect(subject.given_name).to eq('Paul')
  end

  it 'has family_name as the supplied string' do
    expect(subject.family_name).to eq('Mak')
  end

  it 'has mail as the supplied string' do
    expect(subject.mail).to eq('pmak@example.com')
  end

  it 'has roles as an array' do
    expect(subject.roles).to respond_to(:[], :map)
  end
end
