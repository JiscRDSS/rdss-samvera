RSpec.shared_examples 'destroy' do |object|
  let(:hidden_class) { 'hidden' }
  let(:type) { %q(destroy="true") }

  it 'renders a hidden input' do
    expect(object).to include(type)
  end

  it 'renders a hidden class' do
    expect(object).to include(hidden_class)
  end
end