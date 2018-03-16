# In the message map, both organisation and person have roles, which have the same 'role' attribute name.
# Since the organisation role is also mapped as a 'belongs_to' relationship, the linking of the attributes is
# slightly different, so the object_organisation_role map is overridden as an array of the form
# object_organisation_role: [{
#   organisation: { <organisation attributes> }
#   role: <integer>
# }]

module Cdm
  module Messaging
    class ObjectOrganisationRole < MessageMapper
      include AttributeMapper
      attribute_name :object_organisation_roles

      class << self
        def map_organisation_role(mapping, object)
          object.send(attribute_name_in_model).map do |oor|
            ::Cdm::Messaging::Organisation.(:organisation, mapping.first['organisation'], oor.organisation).merge({ role: ::Cdm::Messaging::Enumerations::OrganisationRole.send(oor.role) })
          end.flatten.unshift(default_messaging_oor)
        end

        # As some components of the RDSS are using this field to determine the institution sending the message to inform their processing of the message, 
        # the following default oor populated with information about the HEI cluster is prepended to the list to support this, until such time as it is
        # no longer required. 
        def default_messaging_oor
          {
            organisation: {
              organisationJiscId: Willow::Config.institution_jisc_id,
              organisationName: Willow::Config.institution_name,
              organisationType: ::Cdm::Messaging::Enumerations::OrganisationType.higher_education,
              organisationAddress: Willow::Config.institution_name
            }, 
            role: ::Cdm::Messaging::Enumerations::OrganisationRole.hosting_institution
          }
        end

        def call(name, mapping, object)
          { name.intern=>map_organisation_role(mapping, object) }
        end
      end
    end
  end
end
