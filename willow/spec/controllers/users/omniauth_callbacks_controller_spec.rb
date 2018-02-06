require 'spec_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:shibboleth]
  end

  describe 'sign in' do
    before :each do
      get :shibboleth
    end

    let(:email) { OmniAuth.config.mock_auth[:shibboleth].info.email }
    let(:user) { User.where(email: email).first }

    it 'creates a new user' do
      expect(user).to be_truthy
    end

    it 'creates a session' do
      expect(session['warden.user.user.key'][0][0]).to eq(user.id)
    end

    it 'redirects after sign-in' do
      expect(response.status).to eq(302)
    end
  end
end
