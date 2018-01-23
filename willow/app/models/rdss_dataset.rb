# Generated via
#  `rails generate hyrax:work RdssDataset`
class RdssDataset < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  # include methods to check for enabled and disabled content types
  include EnableContentTypesBehaviour  

  self.indexer = RdssDatasetIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your dataset must have a title.' }

  self.human_readable_type = 'Dataset'

  # value
  property :rating, predicate: ::RDF::Vocab::VMD.rating do |index|
    index.as :stored_searchable, :facetable
  end
  # category
  property :category, predicate: ::RDF::Vocab::PROV.category do |index|
    index.as :stored_searchable, :facetable
  end
  # rights_holder
  property :rights_holder, predicate: ::RDF::Vocab::DC.rightsHolder do |index|
    index.as :stored_searchable, :facetable
  end

  # new 'version' property
  # Had to use rdss_version as name, because app/forms/hyrax/forms/work_form.rb defines a method version
  property :rdss_version, predicate: ::RDF::Vocab::DOAP.Version, multiple: false do |index|
    index.as :stored_searchable
  end

  property :date, predicate: ::RDF::Vocab::DC.date, class_name:"DateStatement"
  property :license_nested, predicate: ::RDF::Vocab::DC.license, class_name:"LicenseStatement"
  property :relation, predicate: ::RDF::Vocab::DC.relation, class_name:"RelationStatement"
  property :identifier_nested, predicate: ::RDF::Vocab::Identifiers.id, class_name: "ObjectIdentifier"
  property :creator_nested, predicate: ::RDF::Vocab::SIOC.has_creator, class_name:"PersonStatement"
  property :organisation_nested, predicate: ::RDF::Vocab::ORG.organization, class_name:"OrganisationStatement"
  property :preservation_nested, predicate: ::RDF::Vocab::PREMIS.hasEvent, class_name:"PreservationStatement"
  has_many :person_roles
  has_many :organisation_roles

  # TODO: Add preservation_event

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
  # keep
  #   label, relative_path, import_url, resource_type, description, keyword,
  #   rights_statement, bibliographic_citation, source
  # remove
  #   creator, contributor, license, publisher, date_created, subject, language,
  #   identifier, based_near, related_url
  include RdssDatasetNestedAttributes
end
