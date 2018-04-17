#Entrypoint for the RdssCdm message generation. The structure of the message map is read from the 'metatdata_request.yml'
# file in config, and this class is called with an object with a structure on the RdssCdm model.

module Cdm
  module Messaging
    class RdssCdm < MessageMapper
      include ConfigFiles

      class << self
        public
        def call(object, event: :create, version: :current)
          config_directories etc: ["#{Rails.root}/config/schema/#{version}/messages/body/metadata/#{event}"]
          dynamic_config_files :request
          super(:rdss_cdm, request, object).values.first
        end
      end
    end
  end
end
