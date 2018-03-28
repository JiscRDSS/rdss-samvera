require 'rails_helper'

RSpec.describe ::Enumerations::Decoders::Api do
  describe 'caches messaging file sections' do
    it 'should raise an error if #call is called' do
      expect { described_class.call('wibble') }.to raise_error StandardError
      expect { described_class.new.call('wibble') }.to raise_error StandardError
    end
  end
end