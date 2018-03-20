module Hyrax
  module Actors
    class RdssCdmObjectVersioningActor < AbstractActor
      public
      def update(env)
        ::Rdss::Actors::PerformCdmVersioning.(env) if CurationConcernApproved.(env) unless ObjectVersionChanged.(env)
        next_actor.update(env)
      end
    end
  end
end
