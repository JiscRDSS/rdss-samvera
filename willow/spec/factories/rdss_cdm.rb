FactoryGirl.define do

  factory :rdss_cdm do
    title ["RDSS CDM"]
    object_rights_attributes [ {rights_statement: ''} ]
    access_control
    skip_create
    override_new_record
  end

end
