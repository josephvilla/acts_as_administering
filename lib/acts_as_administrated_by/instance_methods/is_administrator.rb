module ActsAsAdministratedBy
  module InstanceMethods
    module IsAdministrator

      def is_administrator?(person)
        administrator_ids.include? person.id
      end

    end
  end
end