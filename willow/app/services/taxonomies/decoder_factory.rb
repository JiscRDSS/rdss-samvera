# This class builds classes to return numeric enumeration values from json enumerations of the form:
#
#Filename: "sectionName.json":
# {
#   "vocabularyId": 1,
#   "vocabularyName": "sectionName",
#   "vocabularyValues": [
#     {
#       "valueId": 1,
#       "valueName": "value1"
#     },
#     {
#       "valueId": 2,
#       "valueName": "value2"
#     },
#     {
#       "valueId": 3,
#       "valueName": "value3"
#     }
#   ]
# }
#
# by setting a constant to the return value for the Taxonomy.call('sectionName')
# or by subclassing the Taxonomy.call('sectionName') (This returns a class, so it is entirely appropriate to subclass)
#
# i.e.
# ::Cdm::Messaging::Taxonomies::SectionName = ::Taxonomies::Decoder.call('sectionName')
#
# which in this case would be the equivalent of creating the following class
#
# module Cdm
#   module Messaging
#     module Taxonomies
#       class SectionName
#         class << self
#           def value1
#             1
#           end
#
#           def value2
#             2
#           end
#
#           def value3
#             3
#           end
#         end
#       end
#     end
#   end
# end
#
# Since we don't actually care about the case of the string names, only their symbolic representation and indexes, no
# translation checks other than conversion to symbols needs to be done. The JSON.parser also contains a symboliser
# which may be more efficient than calling underscore.downcase.intern, but I'd prefer to be more explicit until properly
# testing the Json parser version.
#
module Taxonomies
  module DecoderFactory
    class << self
      private
      def default_options
        {
          file: ::Taxonomies::Decoders::File,
          api:  ::Taxonomies::Decoders::Api
        }
      end

      def define_class_for(section, decoder, options)
        Class.new do
          define_singleton_method(:call) do
            options[decoder].(section)
          end

          options[decoder].(section).each do | key, value |
            define_singleton_method(key.underscore.downcase.intern) { value }
          end
        end
      end

      public
      def call(section, decoder=:file, options=default_options)
        define_class_for(section, decoder, options)
      end

      def sections(decoder=:file, options=default_options)
        options[decoder].sections
      end
    end
  end
end
