require 'spec_helper'

RSpec.describe ObjectOrganisationRolesAttributeRenderer do
  describe 'Object Organisation Roles Attribute Renderer' do
    let(:value) do
      [
        {
          role: "advocacy",
          organisation: 
            {
              id: "d30796da-8828-4005-93ec-660b2baace76",
              jisc_id: "123",
              name: "Some Organisation",
              address: "Some Address",
              organisation_type: "billing"
          }
        }].to_json
    end

    subject { Nokogiri::HTML(described_class.new(:object_organisation_roles, value).render) }

    it 'looks up and displays the role' do
      expect(subject.css('.th')[0].text).to eq('Advocacy')
    end

    it 'displays the JISC Id' do
      expect(subject.css('.td')[0].text).to eq('123')
    end

    it 'displays the organisation name' do
      expect(subject.css('.td')[1].text).to eq('Some Organisation')
    end

    it 'displays the organisation type' do
      expect(subject.css('.td')[2].text).to eq('Billing')
    end

    it 'displays the organisation address' do
      expect(subject.css('.tr')[2].css('.td')[3].text).to eq('Some Address')
    end
  end
end