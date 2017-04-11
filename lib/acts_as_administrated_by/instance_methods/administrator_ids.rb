module ActsAsAdministratedBy
  module InstanceMethods
    module AdministratorIds

      def administrator_ids
        ActsAsRelatingTo::Relationship.tagged_with('admin').where(in_relation_to_type: self.class.name, in_relation_to_id: self.id, owner_type: 'BigbeeGraph::Person').map{|r|r.owner_id}
      end

    end
  end
end