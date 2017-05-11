# Generated via
#  `rails generate curation_concerns:work Dataset`

class Dataset < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::CurationConcerns::BasicMetadata
  include Sufia::WorkBehavior
  self.human_readable_type = 'Dataset'
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  property :license, predicate: ::RDF::Vocab::DC.license, class_name:"LicenseStatement"
  property :creator, predicate: ::RDF::Vocab::DC.license, class_name:"PersonStatement"
  property :relation, predicate: ::RDF::Vocab::DC.relation, class_name:"RelationStatement"
  property :publication, predicate: ::RDF::Vocab::DC.isReferencedBy, class_name: "PublicationStatement"
  property :admin_metadata, predicate: ::RDF::Vocab::MODS.adminMetadata, class_name: "AdministrativeStatement"

  # must be included after all properties are declared
  include NestedAttributes

  def to_solr(solr_doc = {})
    super(solr_doc).tap do |doc|
      # license
      doc[Solrizer.solr_name('license', :stored_searchable)] = license.to_json
      doc[Solrizer.solr_name('license', :facetable)] = license.map { |l| l.label.first }
      # creator
      doc[Solrizer.solr_name('person', :stored_searchable)] = creator.to_json
      creators = creator.map { |c| (c.first_name + c.last_name).join(' ') }
      doc[Solrizer.solr_name('creator', :facetable)] = creators
      doc[Solrizer.solr_name('creator', :stored_searchable)] = creators
      # relation
      doc[Solrizer.solr_name('relation', :stored_searchable)] = relation.map { |r| r.url.first }
      # publication
      doc[Solrizer.solr_name('publication', :stored_searchable)] = publication.map { |p| p.title.first }
      doc[Solrizer.solr_name('journal', :stored_searchable)] = publication.map { |p| p.journal.first }
      doc[Solrizer.solr_name('journal', :facetable)] = publication.map { |p| p.journal.first }
    end
  end

end