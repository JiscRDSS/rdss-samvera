RSpec.shared_examples 'labelled' do |object, label_name, required: false|
  let(:label_tag) { 'label' }
  let(:label_required_tag) { %q(<span class="required_tag">*</span>) }
  let(:label_optional_tag) { %q(optional) }

  it 'renders a label' do
    expect(object).to include(label_tag)
  end

  it 'renders the label name' do
    expect(object).to include(label_name)
  end

  it 'only renders a required tag if required' do
    if required
      expect(object).to include(label_required_tag)
    else
      expect(object).to include(label_optional_tag)
    end
  end
end
