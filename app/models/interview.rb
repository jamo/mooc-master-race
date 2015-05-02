class Interview < ActiveRecord::Base
  enum status: [:free, :disabled, :reserved]
  belongs_to :interview_day
  has_one :applicant


  def to_s
    #"#{self.start_time.strftime("%a %d.%m.%Y klo  %H:%M")}"
    "#{self.start_time.strftime("(%H:%M)")}"
  end
end
