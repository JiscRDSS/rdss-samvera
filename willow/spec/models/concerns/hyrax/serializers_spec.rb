require 'spec_helper'
class HyraxSerializersDummy
  include Hyrax::Serializers
  attr_reader :title, :label

  def initialize(title: nil, label: nil)
    @title=title
    @label=label
  end
end

RSpec.describe HyraxSerializersDummy do
  it 'displays "No title" if title and label are falsey' do
    expect(described_class.new.to_s).to eq('No title')
  end

  it 'displays title if title and label are present' do
    expect(described_class.new(title: 'Title', label: 'Label').to_s).to eq('Title')
  end

  it 'displays a concatenated title is title is an array' do
    expect(described_class.new(title: ['An', 'array', 'of', 'titles'], label: 'Just an unused label').to_s).to eq('An | array | of | titles')
  end

  it 'displays label if label present without a title' do
    expect(described_class.new(label: 'Label').to_s).to eq('Label')
  end
end
