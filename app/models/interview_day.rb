class InterviewDay < ActiveRecord::Base
  has_many :interviews
  has_many :applicants, through: :interviews


  class << self
    def old_init_db
      # TODO(jamo): run this later with new updated info
      interview_days = (DateTime.new(2014,4,25)..DateTime.new(2014,5,16)).map do |day|
        next unless is_weekday?(day)
        day = day.change({hour: 8 })
        puts
        puts day.strftime("%a %d.%m.%Y klo  %H:%M")
        InterviewDay.create!(date: day)
      end
      interview_days.each do |interview_day|
        next if interview_day.nil?
        acc_time = interview_day.date
        interview_day.interviews << Interview.create!(start_time: acc_time, duration_in_minutes: 20)
        end_time = interview_day.date.dup.change({hour: 15,min: 30})
        loop do
          acc_time += 15.minutes
          #p ACC: acc_time
          break if end_time < acc_time
          interview_day.interviews << Interview.create!(start_time: acc_time, duration_in_minutes: 20)
        end
      end
    end

    def init_db
      # TODO(jamo): run this later with new updated info
      dates = []
      dates << DateTime.new(2015,4,29)
      dates << DateTime.new(2015,5,4)
      dates << DateTime.new(2015,5,5)
      dates << DateTime.new(2015,5,6)
      dates << DateTime.new(2015,5,7)
      dates << DateTime.new(2015,5,8)
      dates << DateTime.new(2015,5,11)
      dates << DateTime.new(2015,5,12)
      dates << DateTime.new(2015,5,13)
      dates << DateTime.new(2015,5,15)
      dates << DateTime.new(2015,5,18)
      dates << DateTime.new(2015,5,19)
      dates << DateTime.new(2015,5,20)
      interview_days = dates.map do |day|
        next unless is_weekday?(day)
        day = day.change({hour: 8 })
        puts
        puts day.strftime("%a %d.%m.%Y klo  %H:%M")
        InterviewDay.create!(date: day)
      end
      interview_days.each do |interview_day|
        next if interview_day.nil?
        acc_time = interview_day.date
        interview_day.interviews << Interview.create!(start_time: acc_time, duration_in_minutes: 15)
        end_time = interview_day.date.dup.change({hour: 14,min: 00})
        loop do
          acc_time += 15.minutes
          #p ACC: acc_time
          break if end_time < acc_time
          interview_day.interviews << Interview.create!(start_time: acc_time, duration_in_minutes: 15)
        end
      end
    end

    def is_weekday?(day)
      day.monday? or day.tuesday? or day.wednesday? or day.thursday? or day.friday?
    end
  end


end
