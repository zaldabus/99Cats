class CatRentalRequest < ActiveRecord::Base
  attr_accessible :cat_id, :start_date, :end_date, :status

  before_validation(on: :create) do
    self.status ||= 'PENDING'
  end

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, :inclusion =>
    { :in => ['PENDING', 'APPROVED', 'DENIED'] }


  belongs_to :cat,
  :foreign_key => :cat_id,
  :primary_key => :id,
  :class_name => "Cat"

  def approve!
    self.status = "APPROVED"
    self.save
    self.cat.cat_rental_requests.each do |request|
      request.deny if overlapping_requests?
    end
  end

  def deny
    self.status = "DENIED"
    self.save
  end

  def overlapping_requests
    self.cat.cat_rental_requests.where("(start_date > ? AND start_date < ?) OR
    (end_date > ? AND end_date < ?)", self.start_date, self.end_date, self.start_date, self.end_date
    )
  end

  def overlapping_approved_requests?

  end
end
