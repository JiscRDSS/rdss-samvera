require 'spec_helper'

RSpec.describe ::Cdm::Json::ObjectPersonRole do
  let(:values) do
    {role_type: 'author'}.to_json
  end

  subject { described_class.new(JSON.parse(values)) }

  it 'has role_type as a symbol' do
    expect(subject.role_type).to eq(:author)
  end

  it 'decodes the role type to a name' do
    expect(subject.name).to eq('Author')
  end
end
