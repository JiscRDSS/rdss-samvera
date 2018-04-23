require 'spec_helper'

RSpec.describe ObjectOrganisationAttributeRenderer do
  MockOrganisation = Struct.new(:jisc_id, :name, :organisation_type, :address)
  let(:organisation) do
    MockOrganisation.new(
      123,
      'Some Organisation',
      'charity',
      '123 Some street, Some town'
    )
  end

  subject { Nokogiri::HTML(described_class.new.render(organisation)) }

  describe 'Rendered output' do
    describe 'Headers' do
      let(:header) { subject.css('.th') }

      it 'has header for Jisc ID' do
        expect(header[0].text).to eq('Organisation identifier')
      end

      it 'has header for Name' do
        expect(header[1].text).to eq('Name')
      end

    end

    describe 'Organisation Detail Row' do
      let(:cells) { subject.css('.tr').css('.td') }

      it 'has the correct value for Jisc ID' do
        expect(cells[0].text).to eq('123')
      end

      it 'has the correct value for Name' do
        expect(cells[1].text).to eq('Some Organisation')
      end

    end
  end
end
