require_relative 'facets'

class ObjectPersonFormBuilderDummy
  attr_accessor :honorific_prefix, :given_name, :family_name, :honorific_suffix, :mail
end

RSpec.describe ObjectPersonFormBuilder do
  context 'honorific_prefix' do
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_prefix, 'Title', required: false
    it_behaves_like 'optional',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_prefix
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_prefix(required: true), 'Title', required: true
    it_behaves_like 'required',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_prefix(required: true)
    it_behaves_like 'input',     FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_prefix
    it_behaves_like 'named',      FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_prefix, :honorific_prefix
  end

  context 'given_name' do
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).given_name, 'First name', required: true
    it_behaves_like 'required',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).given_name
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).given_name(required: false), 'First name'
    it_behaves_like 'optional',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).given_name(required: false)
    it_behaves_like 'input',     FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).given_name
    it_behaves_like 'named',      FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).given_name, :given_name
  end

  context 'family_name' do
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).family_name, 'Last name', required: true
    it_behaves_like 'required',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).family_name
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).family_name(required: false), 'Last name'
    it_behaves_like 'optional',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).family_name(required: false)
    it_behaves_like 'input',     FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).family_name
    it_behaves_like 'named',      FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).family_name, :family_name
  end

  context 'honorific_suffix' do
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_suffix, 'Honorific suffix', required: false
    it_behaves_like 'optional',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_suffix
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_suffix(required: true), 'Honorific suffix', required: true
    it_behaves_like 'required',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_suffix(required: true)
    it_behaves_like 'input',     FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_suffix
    it_behaves_like 'named',      FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).honorific_suffix, :honorific_suffix
  end

  context 'mail' do
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).mail(required: true), 'Email address', required: true
    it_behaves_like 'required',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).mail(required: true)
    it_behaves_like 'labelled', FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).mail, 'Email address'
    it_behaves_like 'optional',   FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).mail
    it_behaves_like 'email',     FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).mail
    it_behaves_like 'named',      FacetsProxy.(described_class,ObjectPersonFormBuilderDummy).mail, :mail
  end
end
