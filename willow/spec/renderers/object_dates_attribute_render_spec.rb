require 'spec_helper'

RSpec.describe ObjectDatesAttributeRenderer do
  describe 'Object Dates Attribute Renderer' do
    let(:value) do
      [
        {
          id: "84fabbb4-bdc2-4f73-a874-bb88faffbce9",
          date_value: "07/03/2018",
          date_type: "accepted",
          rdss_cdm_id: "sx61dm28w"
        }
      ].to_json
    end

    subject {  Nokogiri::HTML(described_class.new(:object_dates, value).render) }

    it 'looks up and displays the label' do
      expect(subject.css('.td')[0].text).to eq('Accepted')
    end

    it 'displays the identifier value' do
      expect(subject.css('.td')[1].text).to eq('07/03/2018')
    end
  end
end