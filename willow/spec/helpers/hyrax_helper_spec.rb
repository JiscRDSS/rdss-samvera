class HyraxHelperDummy
  extend HyraxHelper
end

RSpec.describe HyraxHelperDummy do
  it 'should have create an add button with #add_another_button' do
    expect(described_class.add_another_button('date')).to include('button')
    expect(described_class.add_another_button('date')).to include('add')
    expect(described_class.add_another_button('date')).to include('controls-add-text')
    expect(described_class.add_another_button('date')).to include('Add another date')
  end

  it 'should have create a remove button with #remove_button' do
    expect(described_class.remove_button('date')).to include('button')
    expect(described_class.remove_button('date')).to include('controls-remove-text')
    expect(described_class.remove_button('date')).to include('Remove date')
  end

end
