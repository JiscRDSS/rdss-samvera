# Generated via
#  `rails generate hyrax:work RdssCdm`
require 'rails_helper'
include Warden::Test::Helpers

# NOTE: If you generated more than one work, you have to set "js: true"
RSpec.feature 'Create a RdssCdm', vcr: true, js: false do
  xit do
    context 'a logged in user' do
      let(:user) { create(:user) }

      before do
        login_as user
      end

      scenario do
        visit new_hyrax_rdss_cdm_path
        fill_in 'Title', with: 'Test RdssCDM'
        fill_in 'Description', with: 'description'
        select 'Article', from: 'Resource type'
        fill_in 'Honorific prefix', with: 'Mr.'
        fill_in 'Given name', with: 'Paul'
        fill_in 'Family name', with: 'Mak'
        fill_in 'Email address', with: 'pmak@example.com'
        select 'Data creator', from: 'Object person roles'
        select 'Collected', from: 'Date'
        click_on('Additional fields')
        fill_in 'Keywords', with: 'keywords'
        fill_in 'Category', with: 'category'
        select 'Normal', from: 'Object value'
        choose('open')
        check('agreement')
        click_on('Files')
        attach_file('files[]', "#{fixture_path}/files/hello_world.pdf")

        # cannot save without invoking Fedora and thus a problem of unrepeatable tests results...
      end
    end
  end
end