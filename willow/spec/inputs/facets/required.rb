RSpec.shared_examples 'required' do |object|
  let(:required_tag) { 'aria-required="true"' }

  it 'renders required if required' do
    expect(object).to include(required_tag)
  end
end