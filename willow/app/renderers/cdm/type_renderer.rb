module Cdm
  class TypeRenderer
    class << self
      def default_mappings
        { }
      end

      def default_type
        Cdm::AutoRenderer
      end

      def map_type(type, mappings)
        mappings[type] || default_type
      end

      def call(value, type=nil, mappings=default_mappings)
        map_type(type, mappings).(value)
      end
    end
  end
end
