class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :clinic, :class_name => "User"
  has_many :patients, :class_name => "User"
  belongs_to :membership
  has_many :payments
  has_many :user_relations
  has_many :rapidfire_answer_groups, :class_name => "Rapidfire::AnswerGroup"
end
