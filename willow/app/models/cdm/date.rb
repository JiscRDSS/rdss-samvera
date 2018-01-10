class Cdm::Date < ActiveTriples::Resource

  include CommonMethods
  
  configure type: ::RDF::Vocab::VCARD.Date
  property :date_value, predicate: ::RDF::Vocab::DC.date
  property :date_type, predicate: ::RDF::Vocab::DC.description
  
end
