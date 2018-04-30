module Cdm
  # Active fedora model representing an object date for an rdss_cdm model
  class PersonIdentifier < ActiveFedora::Base
    belongs_to :object_person, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf, class_name: 'Cdm::ObjectPerson'

    property :person_identifier_value, predicate: ::RDF::Vocab::DataCite.hasIdentifier, multiple: false
    property :person_identifier_type, predicate: ::RDF::Vocab::DataCite.usesIdentifierScheme, multiple: false
  end
end
