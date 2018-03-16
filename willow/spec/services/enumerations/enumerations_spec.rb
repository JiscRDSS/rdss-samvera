require 'rails_helper'

RSpec.describe ::Cdm::Enumerations do
  describe 'generates enumeration classes with class methods' do
    let(:access_type) { 'accessType' }
    let(:access_type_return) { %i(open safeguarded controlled restricted closed) }

    it 'should have methods for the elements in the passed section' do
      expect(::Cdm::Enumerations::AccessType.methods).to include(*access_type_return)
    end

    it 'should have defined other classes too' do
      expect(::Cdm::Enumerations::PersonRole.methods).to include(:administrator)
    end

    it 'should not have polluted one class with the methods of another' do
      expect(::Cdm::Enumerations::AccessType.methods).to_not include(:administrator)
    end
  end
end