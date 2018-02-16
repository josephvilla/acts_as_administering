class Person < ActiveRecord::Base
	acts_as_relating_to :organizations
	acts_as_administrating :organizations, :programs
  acts_as_administrating :foos, class_name: 'Organization'
end
