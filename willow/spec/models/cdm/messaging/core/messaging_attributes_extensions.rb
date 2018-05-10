module Core
  module MessagingAttributesExtensions
    class << self
      def included(base)
        ::Junctions.activate(base, self.name)
      end
    end
  end
end