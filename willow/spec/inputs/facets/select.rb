RSpec.shared_examples 'select' do |object, key, value, tooltip|
  let(:select_tag) { 'select' }
  let(:option_tag) { tooltip.present? ? %Q(<option title="#{tooltip}" value="#{key}">#{value}</option>) : %Q(<option value="#{key}">#{value}</option>) }

  it 'renders a select' do
    expect(object).to include(select_tag)
  end

  it 'renders an expected option' do
    expect(object).to include(option_tag)
  end
end