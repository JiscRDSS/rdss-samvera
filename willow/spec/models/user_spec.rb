require 'spec_helper'

RSpec.describe User, type: :model do
  let(:eppn) { 'some_uid' }
  let(:email) { 'some_email@example.com' }
  let(:name) { 'Some Name' }
  let(:auth) do
    json_data = {
      uid: eppn,
      info: {
        email: email,
        name: name
      }
    }.to_json
    JSON.parse(json_data, object_class: OpenStruct)
  end

  describe '#uid' do
    it { is_expected.to validate_presence_of(:uid) }
    it { is_expected.to validate_uniqueness_of(:uid) }
  end

  describe '.from_omniauth' do
    context 'new user' do
      it 'creates a new record' do
        expect { User.from_omniauth(auth) }.to change { User.count }.by(1)
      end
    end

    context 'existing user' do
      before :each do
        FactoryGirl.create(:user, uid: eppn)
      end

      it 'does not create a new record' do
        expect { User.from_omniauth(auth) }.to change { User.count }.by(0)
      end
    end
  end
end
