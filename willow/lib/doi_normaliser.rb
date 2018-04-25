require 'uri'

class DoiNormaliser
  class << self
    def call(doi_value)
      doi = parse_doi(doi_value)
      if doi 
        [format_doi_url(doi), format_doi_display(doi)]
      else
        [doi_value, doi_value]
      end
    end

    def parse_doi(doi_value)
      if doi_value.include? 'doi.org'
         doi_value = URI(doi_value).path.delete_prefix('/')
      end
      if doi_value.include? 'doi:'
        doi_value.delete_prefix('doi:')
      end
      # v. https://www.crossref.org/blog/dois-and-matching-regular-expressions/
      doi_regex = /^10.\d{4,9}\/[-.;():\d\w]+$/
      if doi_regex.match(doi_value)
        doi_value
      end
    end

    def format_doi_url(doi)
      URI::HTTPS.build({
        :host => 'doi.org',
        :path => '/' + doi
      })
    end

    def format_doi_display(doi)
      "doi: #{doi}"
    end
  end
end
