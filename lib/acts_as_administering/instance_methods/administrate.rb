module ActsAsAdministering
  module InstanceMethods
    module Administrate

      def administrate(thing)
        relate_to thing, as: "admin"
      end

    end
  end
end