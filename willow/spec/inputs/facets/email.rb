require_relative 'input'
RSpec.shared_examples 'email' do |object|
  it_behaves_like 'input', object

  it 'renders a email input' do
    expect(object).to include('type="email"')
  end

  it 'renders an integer class' do
    expect(object).to include('email')
  end
end