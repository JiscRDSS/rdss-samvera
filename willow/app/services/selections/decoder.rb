# This class builds classes to return selection values from json enumerations of the form:
#
#     "sectionName": [
#       'value1',
#       'value2',
#       'value3'
#     ]
#
# i.e.
# ::Cdm::Selections::SectionName = ::Selections::Decoder.call('sectionName')
#
# which in this case would be the equivalent of creating the following class
#
# module Cdm
#   module Selections
#     class SectionName
#       class << self
#         def value1
#           ['value1', 'Internationalized Name for Value 1']
#         end
#
#         def value2
#           ['value2', 'Internationalized Name for Value 2']
#         end
#
#         def value3
#           ['value3', 'Internationalized Name for Value 3']
#         end
#
#         def call
#           [value1, value2, value3]
#         end
#       end
#     end
#   end
# end
#
#
module Selections
  module Decoder
    class << self
      private
      def default_options
        {
          namespace: ::Enumerations,
          comparator: ::Selections::CompareWithOther
        }
      end

      def define_class_for(section, options=default_options)
        Class.new do
          define_singleton_method(:call) do
            ClassificationFactory.(section, options.slice(:namespace)).call.map do |object|
              [I18n.t("rdss.#{section.underscore.downcase.intern}.#{object.underscore.downcase.intern}"), object.underscore.downcase.intern]
            end.sort{ |a, b| options[:comparator].(a,b) }
          end
        end
      end

      public
      def call(section, options={})
        define_class_for(section, default_options.merge(options))
      end
    end
  end
end
