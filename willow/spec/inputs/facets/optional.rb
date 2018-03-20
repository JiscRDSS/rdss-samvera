RSpec.shared_examples 'optional' do |object|
  let(:required_tag) { 'aria-required="false"' }
  let(:optional) { 'optional' }

  it 'does not render required' do
    expect(object).not_to include(required_tag)
  end

  it 'renders optional class' do
    expect(object).to include(optional)
  end
end