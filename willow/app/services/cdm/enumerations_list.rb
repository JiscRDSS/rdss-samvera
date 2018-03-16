module Cdm
  class EnumerationsList
    class << self
      def call
        %w(
            accessType
            checksumType
            dateType
            eduPersonScopedAffiliation
            fileUse
            identifierType
            messageClass
            objectValue
            organisationRole
            organisationType
            personIdentifierType
            personRole
            preservationEventType
            relationType
            resourceType
            storageStatus
            storageType
            uploadStatus
          )
      end
    end
  end
end