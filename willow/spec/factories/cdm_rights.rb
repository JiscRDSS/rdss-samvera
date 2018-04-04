FactoryGirl.define do

  factory :cdm_rights, class: 'Cdm::Right' do
    skip_create
    override_new_record
  end

end
