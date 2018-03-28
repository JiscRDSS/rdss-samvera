RSpec.shared_examples 'select' do |object, key, value|
  let(:select_tag) { 'select' }
  let(:option_tag) { %Q(<option value="#{key}">#{value}</option>) }

  it 'renders a select' do
    expect(object).to include(select_tag)
  end

  it 'renders an expected option' do
    expect(object).to include(option_tag)
  end
end