RSpec.shared_examples 'text_area' do |object|
  let(:input_tag) { 'text' }

  it 'renders a text area' do
    expect(object).to include(input_tag)
  end
end