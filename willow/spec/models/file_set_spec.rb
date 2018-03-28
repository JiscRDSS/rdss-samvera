require 'spec_helper'

RSpec.describe FileSet do
  subject { described_class.new }

  it "has a file_uuid" do
    expect(subject.respond_to?(:file_uuid)).to be_truthy
  end

  it "has a checksum_uuid" do
    expect(subject.respond_to?(:checksum_uuid)).to be_truthy
  end

  it 'sets file_uuid from a create callback' do
    expect(subject.file_uuid).to be_nil
    subject.run_callbacks(:create)
    expect(subject.file_uuid).not_to be_nil
  end

  it 'sets checksum_uuid from a create callback' do
    expect(subject.checksum_uuid).to be_nil
    subject.run_callbacks(:create)
    expect(subject.checksum_uuid).not_to be_nil
  end
end
