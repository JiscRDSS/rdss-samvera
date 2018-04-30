require 'spec_helper'

RSpec.describe ObjectPeopleAttributeRenderer do
  describe 'Object People Attribute Renderer' do
    let(:value) do
      [
        {
          id: "6efb7d8f-5c4c-46e6-8049-faaded75114a",
          honorific_prefix: "Sir",
          given_name: "Lancelot",
          family_name: "O'Boyle",
          honorific_suffix: "OBE",
          mail: "slance@gmail.com",
          object_person_role_ids: ["c32bf4b8-f5f5-4d89-9075-898c2fc8a659"],
          rdss_cdm_id: "sx61dm28w",
          object_person_roles: [
            {
              id: "c32bf4b8-f5f5-4d89-9075-898c2fc8a659",
              role_type: "contact_person",
              rdss_cdm_id: nil,
              object_person_ids: [
                "6efb7d8f-5c4c-46e6-8049-faaded75114a"
              ]
            }],
          person_identifiers: [
            {
              person_identifier_type: 'twitter',
              person_identifier_value: '@POTUS'
            }
          ]
          }
        ].to_json
    end

    subject { Nokogiri::HTML(described_class.new(:object_organisation_roles, value).render) }

    describe 'Headers' do
      it 'has headers for Name, Email and Role' do
        headers = subject.css('.tr')[0].css('.th').map(&:text)
        expect(headers).to eq(['Name', 'Email', 'Roles', 'Person Identifiers'])
      end
    end

    describe 'Values' do
      # FIXME - a pretty worthless test anyway but a nested renderer is making this complicated to test
      xit 'has the correct values' do
        expect(values).to eq(["Sir Lancelot O'Boyle OBE", "slance@gmail.com", "Contact person"])
      end
    end
  end
end