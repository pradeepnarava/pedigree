class UserRelation < ActiveRecord::Base
	has_parents
	belongs_to :user
end
