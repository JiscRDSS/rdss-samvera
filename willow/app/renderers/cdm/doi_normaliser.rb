require 'uri'
module Cdm
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
          #TODO: Check with fmcc that he didn't mean to do URI.() rather than URI()
          doi_value = URI(doi_value.strip()).path.delete_prefix('/')
        end
        if doi_value.include? 'doi:'
          doi_value = doi_value.delete_prefix('doi:')
        end
        doi_value = doi_value.strip()
        # v. https://www.crossref.org/blog/dois-and-matching-regular-expressions/
        doi_regex = /^10.\d{4,9}\/[-.;():\/\d\w]+$/
        if doi_regex.match(doi_value)
          doi_value
        end
      end

      def format_doi_url(doi)
        URI::HTTPS.build({
          :host => 'doi.org',
          :path => '/' + doi
        }).to_s
      end

      def format_doi_display(doi)
        "doi: #{doi}"
      end
    end
  end
end
