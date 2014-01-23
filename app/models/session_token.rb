class SessionToken < ActiveRecord::Base
  attr_accessible :user_id, :token

  validates :user_id, :token, presence: true
  validates :token, uniqueness: true

  belongs_to :user,
             :class_name => "User",
             :foreign_key => :user_id,
             :primary_key => :id

end
