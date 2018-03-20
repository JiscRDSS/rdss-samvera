RSpec.shared_examples 'unlabelled' do |object|
  let(:label_tag) { 'label' }

  it 'does not render a label' do
    expect(object).not_to include(label_tag)
  end
end