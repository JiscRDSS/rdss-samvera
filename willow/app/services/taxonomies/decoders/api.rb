module Taxonomies
  module Decoders
    class Api
      class << self
        def call(section)
          self.new.call(section)
        end
      end

      def initialize(api_endpoint='')
        #Not Implemented. Possibly should be Singleton or cached
      end

      def call(section)
        raise StandardError, 'API based Taxonomy decoder doesn\`t currently exist'
      end
    end
  end
end
