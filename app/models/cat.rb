class Cat < ActiveRecord::Base
  attr_accessible :age, :birth_date, :color, :name, :sex, :user_id

  validates :age, :birth_date, :color, :name, :sex, :user_id, presence: true
  validates :age, numericality: { only_integer: true }
  validates :color,
    :inclusion => { :in => ['brown', 'black', 'red', 'orange', 'blue', 'yellow', 'green'] }
  validates :sex, :inclusion => { :in => ['F', 'M'] }

  has_many :cat_rental_requests,
  :foreign_key => :cat_id,
  :primary_key => :id,
  :class_name => "CatRentalRequest",
  :dependent => :destroy

  belongs_to :owner,
             :foreign_key => :user_id,
             :primary_key => :id,
             :class_name => "User"

end
