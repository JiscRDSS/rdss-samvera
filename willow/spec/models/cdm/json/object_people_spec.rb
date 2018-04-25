require 'spec_helper'

RSpec.describe ::Cdm::Json::ObjectPeople do
  let(:values) do
    [{
      honorific_prefix: 'Mr.',
      given_name: 'Paul',
      family_name: 'Mak',
      mail: 'pmak@example.com',
      object_person_roles: [{role_type: 'author'}, {role_type: 'editor'}],
      person_identifiers: []
    }].to_json
  end

  subject { described_class.new(values) }

  it 'has people as an array' do
    expect(subject.people).to respond_to(:[], :map)
  end
end
