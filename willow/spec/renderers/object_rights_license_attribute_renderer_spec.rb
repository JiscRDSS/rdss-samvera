require 'spec_helper'

RSpec.describe ObjectRightsLicenceAttributeRenderer do
  describe 'Object People Attribute Renderer' do
    let(:value) { 'http://opendefinition.org/licenses/cc-zero/' }

    subject { Nokogiri::HTML(described_class.new(:object_rights_license, value).render) }

    it 'has the correct HREF' do
      expect(subject.css('a')[0].attributes['href'].value).to eq(value)
    end

    it 'has the correct anchor text' do
      expect(subject.css('a')[0].text).to eq('Creative Commons CC Zero License (cc-zero)')
    end
  end
end