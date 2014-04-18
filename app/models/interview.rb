class Interview < ActiveRecord::Base
  enum status: [:free, :disabled, :reserved]
  belongs_to :interview_day
  has_one :applicant


end
