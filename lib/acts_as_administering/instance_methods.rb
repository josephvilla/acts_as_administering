require 'acts_as_administering/instance_methods/administer'
require 'acts_as_administering/instance_methods/administrate'

module ActsAsAdministering
  module InstanceMethods
    include Administer
    include Administrate

    def administered(thing_key)
      @administered_things_ids = self
        .send("owned_relationships_to_"+thing_key.to_s)
        .tagged_with('admin')
        .all
        .map(&:in_relation_to_id)
      @administered_things = thing_constant(thing_key)
        .where(id: @administered_things_ids)
    end

    def administers?(thing)
      relates_to_as?(thing, 'admin')
    end
    
    #===========================================================================
    #===========================================================================
    def thing_constant(thing_key)
      thing_key.to_s.singularize.camelize.constantize
    end

        
  end
end