# This class is an extension to MessageMapper to decode an enumeration using the Enumerations::<Name> for
# the <Name> mapping class. This will call the enumerated list with the token and return the numeric value
# for it.

module Cdm
  module Messaging
    class EnumerationMapper < MessageMapper
      private
      attr_reader :options

      def defaults
        {
          factory: ::EnumerationFactory
        }
      end

      def initialize(options={})
        @options=default.merge(options)
      end

      def factory
        options[:factory]
      end

      def mapper
        factory.(self.class.name.demodulize)
      end

      def mapped_attribute_value(value)
        mapper.send(value.underscore.downcase) unless value.blank?
      end

      public
      def value(object, attribute)
        begin
          mapped_attribute_value(object.send(attribute))
        rescue Exception => e
          puts("Exception in decoding #{attribute} in #{self.class.name} for #{object}")
        end
      end
    end
  end
end