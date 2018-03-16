# This class builds classes to return numeric enumeration values from json enumerations of the form:
#
#     "sectionName": [
#       'value1',
#       'value2',
#       'value3'
#     ]
#
# by setting a constant to the return value for the EnumDecoder.call('sectionName')
# or by subclassing the EnumDecoder.call('sectionName') (This returns a class, so it is entirely appropriate to subclass)
#
# i.e.
# ::Cdm::Messaging::Enumerations::SectionName = ::Enumerations::Decoder.call('sectionName')
#
# which in this case would be the equivalent of creating the following class
#
# module Cdm
#   module Messaging
#     module Enumerations
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
module Enumerations
  module Decoder
    class << self
      private
      def types
        {
          :file=>::Enumerations::Decoders::File,
          :api=>::Enumerations::Decoders::Api
        }
      end

      def define_class_for(section, decoder, endpoint)
        Class.new do
          define_singleton_method(:call) do
            decoder.(section, endpoint)
          end

          # TODO This will need to change before v3.0.0 of the CDM is released, since it's going to have to pick up
          # values from the Taxonomy endpoint rather than from here.
          decoder.(section, endpoint).each_with_index do | object, index |
            define_singleton_method(object.underscore.downcase.intern) { (index+1) }
          end
        end
      end

      public
      def call(section, type=:file, endpoint="#{Rails.root.to_s}/config/schema/current/enumeration.json")
        define_class_for(section, types[type], endpoint)
      end
    end
  end
end
