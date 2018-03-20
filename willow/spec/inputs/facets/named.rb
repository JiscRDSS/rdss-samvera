RSpec.shared_examples 'named' do |object, name, array: false|
  it 'sets the correct name for' do
    expect(object).to include(%Q(name="foo[#{name}]#{array ? '[]' : ''}"))
  end

  it 'sets the correct id for access_statement' do
    expect(object).to include(%Q(id="foo_#{name}"))
  end
end