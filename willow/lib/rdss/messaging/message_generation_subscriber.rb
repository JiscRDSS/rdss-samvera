module Rdss
  module Messaging
    class MessageGenerationSubscriber
      private
      def after_object_upload_complete(object, &block)
        object.reload unless object.new_record? #Can't reload an object that hasn't been saved.
        Thread.new(object, object.uploaded_files_count) { |object, count|
          while (object.file_sets.count.to_i < count.to_i) do
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
        # If you need to debug, comment out the previous two lines and uncomment the following two. This will let you
        # see errors hidden if the system throws a masked exception in the Thread.
        # }.join
        # yield(object)
      end

      private
      def event_mapper
        {
          create: Hyrax::Notifications::Events::METADATA_CREATE,
          update: Hyrax::Notifications::Events::METADATA_UPDATE,
          delete: Hyrax::Notifications::Events::METADATA_DELETE
        }
      end

      def instrument_notification(object, event: :create)
        with_generated_message(object, event: event) do |message, mapped_event|
          ActiveSupport::Notifications.instrument(mapped_event, message)
        end
      end

      def with_generated_message(object, event: create)
        yield(message_builder(object, event: event), event_mapper[event])
      end

      public
      def message_builder(object, event:)
        Rdss::Messaging::Generators::BuildMessage.(object, event: event)
      end

      def work_approval(rdss_cdm)
        after_object_upload_complete(rdss_cdm) do |object|
          instrument_notification(object, event: :create)
        end
      end

      def work_update(rdss_cdm)
        after_object_upload_complete(rdss_cdm) do |object|
          instrument_notification(object, event: :update)
        end
      end

      def work_destroy(rdss_cdm)
        instrument_notification(rdss_cdm, event: :delete)
      end
    end
  end
end
