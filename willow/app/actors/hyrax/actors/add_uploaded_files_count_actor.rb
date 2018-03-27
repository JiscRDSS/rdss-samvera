module Hyrax
  module Actors
    class AddUploadedFilesCountActor < AbstractActor
      private
      def add_uploaded_files_count(env)
        env.attributes[:uploaded_files_count] = (env.attributes[:uploaded_files]&.count).to_i
      end

      public
      def create(env)
        add_uploaded_files_count(env)
        next_actor.create(env)
      end

      def update(env)
        add_uploaded_files_count(env)
        next_actor.update(env)
      end
    end
  end
end
