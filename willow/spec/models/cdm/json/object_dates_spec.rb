require 'spec_helper'

RSpec.describe ::Cdm::Json::ObjectDates do
  let(:values) do
    [{
      date_type: 'accepted',
      date_value: ::Time.at(0).to_s
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
