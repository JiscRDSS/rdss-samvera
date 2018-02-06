# frozen_string_literal: true
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def shibboleth
      user = resource_class.from_omniauth(request.env['omniauth.auth'])
      set_flash_message :notice, :success, kind: 'RDSS Samvera'
      sign_in_and_redirect user
    end
  end
end
