class InterviewDay < ActiveRecord::Base
  has_many :interviews
  has_many :applicants, through: :interviews


  class << self

    def init_db
      interview_days = (DateTime.new(2014,4,25)..DateTime.new(2014,5,16)).map do |day|
        #next if is_weekday?(day)
        day = day.change({hour: 8 })
        InterviewDay.create!(date: day)
      end

      interview_days.map do |interview_day|
        acc_time = interview_day.date
        interview_day.interviews << Interview.create!(start_time: acc_time, duration_in_minutes: 20)
        end_time = interview_day.date.dup.change({hour: 15,min: 30})
        loop do
          acc_time += 15.minutes
          p ACC: acc_time
          break if end_time <= acc_time
          interview_day.interviews << Interview.create!(start_time: acc_time, duration_in_minutes: 20)
        end
      end
    end

    def is_weekday?(day)
      day.monday? or day.tuesday? or day.wednesday? or day.thursday? or day.friday?
    end
  end


end
