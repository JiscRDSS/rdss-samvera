require 'rails_helper'

RSpec.describe Cdm::Right do
  # since this is a model, we just check it can build the correct fields

  describe 'rights statement' do
    it 'has a rights statement' do
      obj = build(:cdm_rights, rights_statement: ['test rights statement'])
      expect(obj.rights_statement).to be_kind_of ActiveTriples::Relation
      expect(obj.rights_statement).to eq ['test rights statement']
    end
  end
    
  describe 'rights holder' do
    it 'has a rights holder' do
      obj = build(:cdm_rights, rights_holder: ['test rights holder'])
      expect(obj.rights_holder).to be_kind_of ActiveTriples::Relation
      expect(obj.rights_holder).to eq ['test rights holder']
    end
  end
    
  describe 'licence' do
    it 'has a licence' do
      obj = build(:cdm_rights, licence: ['http://creativecommons.org/licenses/by/3.0/us/'])
      expect(obj.licence).to be_kind_of ActiveTriples::Relation
      expect(obj.licence).to eq ['http://creativecommons.org/licenses/by/3.0/us/']
    end
  end

  describe 'nested attributes for accesses' do
    it 'accepts accesses attributes' do
      obj = build(:cdm_rights, accesses_attributes: [{ access_type: 'controlled', access_statement: 'Statement 1' }])
      expect(obj.accesses.first).to be_kind_of ActiveFedora::Base
      expect(obj.accesses.first.access_type).to eq 'controlled'
      expect(obj.accesses.first.access_statement).to eq 'Statement 1'
    end

    it 'rejects accesses attributes if type is blank' do
      obj = build(:cdm_rights, accesses_attributes: [
                                                  {
                                                    access_statement: 'statement 1',
                                                    access_type: 'controlled'
                                                  },
                                                  {
                                                    access_type: 'controlled'
                                                  },
                                                  {
                                                    access_statement: 'statement 2'
                                                  },
                                                  {
                                                    access_statement: ''
                                                  }
                                                ])
      expect(obj.accesses.size).to eq(2)
    end
  end
    
end