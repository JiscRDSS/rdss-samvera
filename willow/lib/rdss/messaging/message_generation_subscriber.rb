module Rdss
  module Messaging
    class MessageGenerationSubscriber
      private
      def after_object_upload_complete(object, &block)
        Thread.new(object, object.uploaded_files_count) { |object, count|
          while (object.file_sets.count < count) do
            sleep(60)
            object.reload
          end
          object.file_sets.map do |ofs|
            Thread.new(ofs) {
              while (!ofs.original_checksum.present?) do
                sleep(60)
                ofs.reload
              end
            }
          end.each(&:join)
          yield(object)
        }
      end

      public
      def message_builder(object, event:)
        Rdss::Messaging::Generators::BuildMessage.(object, event: event)
      end

      def work_approval(rdss_cdm)
        after_object_upload_complete(rdss_cdm) do |object|
          ActiveSupport::Notifications.instrument(::Hyrax::Notifications::Events::METADATA_CREATE, message_builder(object, event: :create))
        end
      end

      def work_update(rdss_cdm)
        after_object_upload_complete(rdss_cdm) do |object|
          ActiveSupport::Notifications.instrument(::Hyrax::Notifications::Events::METADATA_UPDATE, message_builder(object, event: :update))
        end
      end

      def work_destroy(rdss_cdm)
        after_object_upload_complete(rdss_cdm) do |object|
          ActiveSupport::Notifications.instrument(::Hyrax::Notifications::Events::METADATA_DELETE, message_builder(object, event: :delete))
        end
      end
    end
  end
end
