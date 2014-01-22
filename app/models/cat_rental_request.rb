class CatRentalRequest < ActiveRecord::Base
  attr_accessible :cat_id, :start_date, :end_date, :status

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, :inclusion =>
    { :in => ['PENDING', 'APPROVED', 'DENIED'] }


  belongs_to :cat,
  :foreign_key => :cat_id,
  :primary_key => :id,
  :class_name => "Cat"

  def overlapping_requests?(request1, request2)
    (request1.cat_id == request2.cat_id) && (
      (request1.end_date > request2.start_date) ||
      (request2.end_date > request1.start_date)
    )
  end

  def overlapping_approved_requests?(request1, request2)
    overlapping_requests?(request1, request2) &&
      (request1.status == 'APPROVED') &&
      (request2.status == 'APPROVED')
  end
end
