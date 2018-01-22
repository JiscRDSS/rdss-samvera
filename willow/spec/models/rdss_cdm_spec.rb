# Generated via
#  `rails generate hyrax:work RdssCdm`
require 'rails_helper'

RSpec.describe RdssCdm do
  def build_field(field_name:, content:)
    build(:rdss_cdm, field_name => content)
  end

  def build_and_index_field(field_name:, content:, index_name:)
    build_field(field_name: field_name, content: content).to_solr[index_name.to_s]
  end

  def build_and_check_field(field_name:, content:)
    expect(build_field(field_name: field_name, content: content).send(field_name)).to eq content
  end

  def build_and_check_index(field_name:, content:, index_name:)
    expect(build_and_index_field(field_name: field_name, content: content, index_name: index_name)).to eq [content].flatten(1)
  end


  it 'has human readable type rdss_cdm' do
    @obj = build(:rdss_cdm)
    expect(@obj.human_readable_type).to eq('RDSS CDM')
  end

  describe 'title' do
    it 'requires title' do
      @obj = build(:rdss_cdm, title: nil)
      #@obj.save!
      expect{@obj.save!}.to raise_error(ActiveFedora::RecordInvalid, 'Validation failed: Title Your work must have a title.')
    end

    it 'has a single valued title field' do
      @obj = build(:rdss_cdm, title: ['test rdss_cdm']) # Note it's actually multivalue so we set it as an array
      expect(@obj.title).to eq 'test rdss_cdm' # but title is returned as a single string
    end

    it 'indexes title' do
      build_and_check_index(field_name: :title, content: %w(title), index_name: :title_tesim)
    end
  end


  describe 'version' do
    it 'has a version' do
      build_and_check_field(field_name: :object_version, content: 'version')
    end

    it 'indexes version' do
      build_and_check_index(field_name: :object_version, content: 'version', index_name: :object_version_tesim)
    end
  end

  # single valued
  describe 'uuid' do
    it 'has uuid' do
      build_and_check_field(field_name: :object_uuid, content: 'uuid')
    end
  end

  describe 'description' do
    it 'has description' do
      build_and_check_field(field_name: :object_description, content: 'description')
    end

    it 'indexes description' do
      build_and_check_index(field_name: :object_description, content: 'description', index_name: :object_description_tesim)
    end
  end

  describe 'keywords' do
    it 'has keywords' do
      build_and_check_field(field_name: :object_keywords, content: %w(keywords))
    end

    it 'indexes keywords' do
      build_and_check_index(field_name: :object_keywords, content: %w(keywords), index_name: :object_keywords_tesim)
    end
  end

  describe 'category' do
    it 'has category' do
      build_and_check_field(field_name: :object_category, content: %w(category))
    end

    it 'indexes category' do
      build_and_check_index(field_name: :object_category, content: %w(category), index_name: :object_category_tesim)
    end
  end

  # object_date tests

  describe 'nested attributes for object_date' do
    it 'accepts object_date attributes' do
      @obj = build(:rdss_cdm, object_date_attributes: [{ date_value: '2017-01-01', date_type: 'copyrighted' }])
      expect(@obj.object_date.first).to be_kind_of ActiveTriples::Resource
      expect(@obj.object_date.first.date_value).to eq ['2017-01-01']
      expect(@obj.object_date.first.date_type).to eq ['copyrighted']
    end

    it 'has the correct uri' do
      @obj = build(:rdss_cdm, object_date_attributes: [{ date_value: '2017-01-01', date_type: 'copyrighted' }])
      expect(@obj.object_date.first.id).to include('#object_date')
    end

    it 'rejects date attributes if date is blank' do
      @obj = build(:rdss_cdm, object_date_attributes: [
                                                  {
                                                    date_value: '2017-01-01',
                                                    date_type: 'copyrighted'
                                                  },
                                                  {
                                                    date_type: 'copyrighted'
                                                  },
                                                  {
                                                    date_value: '2018-01-01'
                                                  },
                                                  {
                                                    date_value: ''
                                                  }
                                                ])
      expect(@obj.object_date.size).to eq(2)
    end

    it 'destroys date' do
      @obj = build(:rdss_cdm, object_date_attributes: [{ date_value: '2017-01-01', date_type: 'copyrighted' }])
      expect(@obj.object_date.size).to eq(1)
      @obj.attributes = {
        object_date_attributes: [{
          id: @obj.object_date.first.id,
          date_value: '2017-01-01',
          date_type: 'copyrighted',
          _destroy: '1'
        }]
      }
      expect(@obj.object_date.size).to eq(0)
    end

    it 'indexes the date' do
      @obj = build(:rdss_cdm, object_date_attributes: [{
                                                    date_value: '2017-01-01',
                                                    date_type: 'copyrighted',
                                                }, {
                                                    date_value: '2018-01-01'
                                                }])
      @doc = @obj.to_solr
      expect(@doc).to include('object_date_ssm')
      expect(@doc['object_date_copyrighted_ssi']).to match_array(['2017-01-01'])
    end
  end


  # describe 'person role' do
  #   it 'has person role' do
  #     build_and_check_field(field_name: :object_person_role, content: %w(author))
  #   end
  #
  #   it 'indexes person role' do
  #     build_and_check_index(field_name: :object_person_role, content: %w(author), index_name: :object_person_role_tesim)
  #   end
  # end
end
