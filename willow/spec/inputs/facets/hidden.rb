RSpec.shared_examples 'hidden' do |object|
  let(:hidden_class) { 'hidden' }
  let(:type) { %q(type="hidden") }

  it 'renders a hidden input' do
    expect(object).to include(type)
  end

  it 'renders a hidden class' do
    expect(object).to include(hidden_class)
  end
end