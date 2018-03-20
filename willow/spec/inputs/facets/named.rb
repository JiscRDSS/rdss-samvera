RSpec.shared_examples 'named' do |object, name|
  it 'sets the correct name for' do
    expect(object).to include(%Q(name="foo[#{name}]"))
  end

  it 'sets the correct id for access_statement' do
    expect(object).to include(%Q(id="foo_#{name}"))
  end
end