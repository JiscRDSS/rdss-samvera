# TODO This is all wrong, but it's putting something into the header which is valid. Once we get past the happy
# path on this one, we need to add in error messages etc from a schema validation
module Rdss
  module Messaging
    module Generators
      class GenerateHeader
        class << self
          def call(event: :create, version: :current, errors: [])
            new(event: event, version: version).call(errors: errors)
          end
        end

        private
        attr_reader :event, :version

        def initialize(event: :create, version: :current)
          @event=event
          @version=version
        end

        def default_version
          version_map[:current]
        end

        def version_map
          {
            'current': '3.0.1',
            '1.2.1': '1.2.1',
            '2.1.0': '2.1.0',
            '3.0.1': '3.0.1'
          }
        end

        def decode_errors(errors)
          {
            errorDescription: errors.join('; '),
            errorCode: 'GENERR001'
          }
        end

        def errors_hash(errors)
          errors.present? ? decode_errors(errors) : {}
        end
        
        def default_hash
          {
            messageId: ::SecureRandom.uuid,
            messageClass: 'Event',
            messageHistory: [{
              machineId: ENV['SAMVERA_INTERNAL_HOST'],
              machineAddress: ENV['SAMVERA_INTERNAL_HOST'],
              timestamp: DateTime.now.rfc3339,
            }],
            messageType: "Metadata#{event.to_s.camelize}",
            messageTimings: {
              publishedTimestamp: DateTime.now.rfc3339,
              expirationTimestamp: (DateTime.now+1.week).rfc3339
            },
            messageSequence: { sequence:SecureRandom.uuid,
                               position: 1,
                               total: 1
            },
            version: version_map[version.intern]||default_version,
            generator: 'Samvera'
          }
        end
        
        public
        def call(errors:)
          default_hash.merge( errors_hash(errors) )
        end
      end
    end
  end
end
