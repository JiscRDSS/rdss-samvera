module Rdss
  module Messaging
    module Generators
      module Core
        module VersionMapper
          class << self
            def included(base)
              ::Junctions.activate(base, self.name)
            end
          end
        end
      end
    end
  end
end
