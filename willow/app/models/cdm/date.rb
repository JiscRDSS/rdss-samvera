class Cdm::Date < ActiveTriples::Resource

  include CommonMethods
  
  configure type: ::RDF::Vocab::VCARD.Date
  property :date_value, predicate: ::RDF::Vocab::DC.date
  property :date_type, predicate: ::RDF::Vocab::DC.description

  ## Necessary to get AT to create hash URIs.
  # Added in the initializer from cottaglabs, as it seems to prevent errors when entering the date into fedora
  # However I've added in default values for the parameters so it is possible to call Cdm::Date.new with no parameters.
  def initialize(uri=nil, parent=nil)
    if uri
      if uri.try(:node?)
        uri = RDF::URI("#object_date#{uri.to_s.gsub('_:', '')}")
      elsif uri.start_with?("#")
        uri = RDF::URI(uri)
      end
    end
    super
  end
  
end
