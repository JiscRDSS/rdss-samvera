require 'spec_helper'

RSpec.describe ::Cdm::Json::ObjectPersonRoles do
  let(:values) do
    [{role_type: 'author'}, {role_type: 'editor'}].to_json
  end

  subject { described_class.new(values) }

  it 'has role_types as an array' do
    expect(subject.role_types).to respond_to(:[], :map)
  end
end
