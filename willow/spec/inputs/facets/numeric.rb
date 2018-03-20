require_relative 'input'
RSpec.shared_examples 'numeric' do |object|
  it_behaves_like 'input', object

  it 'renders a numeric input' do
    expect(object).to include('integer')
  end
end