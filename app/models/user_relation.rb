class UserRelation < ActiveRecord::Base
	has_parents current_spouse: true
	belongs_to :user
end
