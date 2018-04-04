require 'singleton'
module Taxonomies
  module Decoders
    class File
      include Singleton
      class << self
        public
        def call(section)
          instance.call(section)
        end

        def sections
          instance.sections
        end

        private
        def instance
          @__instance__ ||= new
        end
      end

      public
      def call(section)
        @__cache__[section] && @__cache__[section]['vocabularyValues'].each_with_object({}) { |value, memo| memo[value['valueName']] = value['valueId'] }
      end

      def sections
        @__cache__.keys
      end

      private
      def file_suffix
        '.json'
      end

      def taxonomy_filenames(directory_name)
        ::Dir.glob(::File.join(directory_name, "*#{file_suffix}"))
      end

      def initialize(directory_name="#{Rails.root.to_s}/config/schema/current/taxonomy")
        @__cache__ = taxonomy_filenames(directory_name).each_with_object({}) { |filename, memo| memo[::File.basename(filename, file_suffix)] = JSON.parse(::File.read(filename)) }
      end
    end
  end
end
