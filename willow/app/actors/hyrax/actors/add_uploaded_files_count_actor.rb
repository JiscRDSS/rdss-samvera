module Hyrax
  module Actors
    class AddUploadedFilesCountActor < AbstractActor
      public
      def create(env)
        env.attributes[:uploaded_files_count] = (env.attributes[:uploaded_files]&.count).to_i
        next_actor.create(env)
      end

      def update(env)
        env.attributes[:uploaded_files_count] = env.curation_concern.uploaded_files_count.to_i + (env.attributes[:uploaded_files]&.count).to_i
        next_actor.update(env)
      end
    end
  end
end
