module ActsAsAdministering
  module DefineMethods
    module StopAdministratingThisThingRemote

      def define_method_stop_administrating_this_thing_remote(class_sym, options={})
        singular = class_sym.to_s.singularize
        #expected_class_name = options[:class_name] || singular.camelize
        #expected_class = expected_class_name.constantize
        define_method("stop_administrating_this_#{singular}") do |thing|
          raise "not implemented!"
=begin
          if thing.is_a?(expected_class)
            owned_relationships.where(in_relation_to: thing).tagged_with('admin').each do |relationship|
              relationship.tag_list_on(:roles).remove('admin')
              relationship.save!
            end
          else
            raise "in #{my_klass}.#{__method__}, expected a #{expected_class_name}, but got a #{thing.class.name}"
          end
=end
        end
      end

      private :define_method_stop_administrating_this_thing_remote

    end
  end
end