require 'spec_helper'

RSpec.describe ::Selections::CompareWithOther do
  describe 'compares two arrays suitable for select with for case insensitive ordering putting :other and :unknown last' do
    it 'should always have :unknown last' do
      expect(described_class.(['Wibble', :wibble], ['Unknown', :unknown])).to eq(-1)
      expect(described_class.(['Unknown', :unknown], ['Wibble', :wibble])).to eq(1)
      expect(described_class.(['Random string', :other], ['Unknown', :unknown])).to eq(-1)
      expect(described_class.(['Another Random String', :unknown], ['Other', :other])).to eq(1)
    end

    it 'should always have :other last in not comparing to :unknown' do
      expect(described_class.(['Wibble', :wibble], ['Other', :other])).to eq(-1)
      expect(described_class.(['Other', :other], ['Wibble', :wibble])).to eq(1)
      expect(described_class.(['Unknown', :unknown], ['Other', :other])).to eq(1)
      expect(described_class.(['Other', :other], ['Unknown', :unknown])).to eq(-1)
    end

    it 'should always have everything else alphabetical by name regardless of what order the keys might have' do
      expect(described_class.(['Wibble', :wibble], ['Aardvark', :zzzzzz])).to eq(1)
      expect(described_class.(['anything', :any_key], ['Behind', :wibble])).to eq(-1)
      expect(described_class.(['Unknown', :not_really], ['other', :another])).to eq(1)
      expect(described_class.(['Last', :before], ['First', :after])).to eq(1)
    end
  end
end