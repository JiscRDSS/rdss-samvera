require 'spec_helper'

RSpec.describe Hyrax::ContactForm do
  let(:happy_attributes) { {email: 'paul.mak@example.com', category: 'browsing message', name: 'Paul Mak', subject: 'Testing', message: 'This is a happy test'} }
  let(:constructed_happy) { { subject: "Jisc Samvera Contact form: Testing", to: 'repo-admin@your-institution.ac.uk', from: 'repo-admin@your-institution.ac.uk' } }
  subject { described_class.new(happy_attributes) }

  let(:spam_attribute) { happy_attributes.merge({contact_method: 'sneaky hidden robot field'}) }

  it "has required attributes" do
    expect(subject).to have_attributes(happy_attributes)
  end

  it 'has a defined header' do
    expect(subject.headers).to eq(constructed_happy)
  end

  it 'is not spam' do
    expect(subject.spam?).to be_falsey
  end

  it 'is spam if the contact_method is filled in' do
    expect(described_class.new(spam_attribute).spam?).to be_truthy
  end

  #Ugh. The following shouldn't be class methods in the model. Thanks Hyrax.
  it 'is expected to respond to #issue_types_for_locale with a list of issues for the email form' do
    expect(described_class.respond_to?(:issue_types_for_locale)).to be_truthy
    expect(described_class.issue_types_for_locale).to be_a_kind_of(Array)
  end
end
