module ActsAsAdministratedBy
  module ClassMethods
    module AdministratedBy
      def administrated_by(person, options={})
        if self < ActiveRecord::Base
          in_relation_to_ids = ActsAsRelatingTo::Relationship.tagged_with('admin').where(owner_type: person.class.name, owner_id: person.id, in_relation_to_type: self.name).map{|r|r.in_relation_to_id}
          self.find(in_relation_to_ids)
        else
          @caller = __method__.to_s
          @person = person
          @options = options[self.to_s.demodulize.underscore.singularize]
          res = generic('get')
        end
      end

      def administrated_by_url
        @url = "#{my_klass.app_provider.url}/#{my_object_name.pluralize}/administrated_by/#{@person.id}"
        @url = @url + "?#{@options.to_query(self.to_s.demodulize.underscore.singularize)}" if @options
        @url
      end

    end
  end
end