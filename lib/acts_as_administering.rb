require "acts_as_administering/engine"
require "acts_as_administrated_by"
require "acts_as_administering/instance_methods"
require "acts_as_administering/method_builders"
require_dependency "acts_as_administering/class_methods"

module ActsAsAdministering

	def acts_as_administrating(*classes_array)
		class_eval do
			include InstanceMethods
			extend  ClassMethods
			extend  MethodBuilders

			simple_method 	= :acts_as_administrating_simple
			optioned_method = :acts_as_administrating_optioned
			method_to_use 	= (is_array_of_keys?(classes_array) ? simple_method : optioned_method)
			send method_to_use, classes_array

		end			
	end

	def acts_as_administering(*classes_array)
		class_eval do
			include InstanceMethods
			extend	ClassMethods
			extend 	MethodBuilders

			classes_array.each do |class_sym|
				define_administrated_things_method class_sym
				define_administrated_thing_with class_sym
				
				define_method("administers_" + class_sym.to_s + "?") do
					true
				end		
				
				define_method("administered_#{class_sym.to_s}") do |**options|
					#send "administers_#{class_sym.to_s}?"
					@administered_things_ids = self
						.send("owned_relationships_to_"+class_sym.to_s)
						.tagged_with('admin')
						.all
						.map(&:in_relation_to_id)
					@administered_things = thing_constant(class_sym)
						.where(id: @administered_things_ids)
				end

			end

		end
	end
	
	module ClassMethods
		
	end
	
end

ActiveRecord::Base.extend ActsAsAdministering
