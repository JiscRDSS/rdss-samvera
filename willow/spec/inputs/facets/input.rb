RSpec.shared_examples 'input' do |object|
  let(:input_tag) { 'input' }

  it 'renders an input' do
    expect(object).to include(input_tag)
  end
end