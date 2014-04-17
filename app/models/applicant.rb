require 'tmc_connection'
class Applicant < ActiveRecord::Base

  has_one :interview
  has_one :interview_day, through: :interview

  before_create :set_key


  def set_key
    self.key = SecureRandom.uuid
  end

  def to_param
    self.key
  end

  class << self
    def update_all_data_with_tmc
      data = TmcConnection.new.download!
      participants = data[:data]
      week_data = data[:week_data]

      participants.select! do |participant|
        participant['hakee_yliopistoon_2014']
      end

      participants.each do |participant|
        applicant = Applicant.where(nick: participant['username']).first || Applicant.create(
          name: participant['koko_nimi'],
          nick: participant['username'],
          email: participant['email']
        )
        # Let's update timestamps to see that we really have done smthing
        applicant.touch
        update_week_percentage(applicant, participant['groups'])
        check_compulsary_exercises(applicant, participant, week_data)
        applicant.save!
      end



    end

    private

    def update_week_percentage(applicant, groups)
      1.upto(12).each do |i|
        details = groups["viikko#{i}"]
        result = details ? (details['points'].to_f / details['total'].to_f) * 100 : -1
        applicant.send("week#{i}=".to_sym, result)
      end
    end

    def check_compulsary_exercises(applicant, participant, week_data)
      compulsory_points = {'6' => %w(102.1 102.2 102.3 103.1 103.2 103.3), '7' => %w(116.1 116.2 116.3),
                           '8' => %w(124.1 124.2 124.3 124.4), '9' => %w(134.1 134.2 134.3 134.4 134.5),
                           '10' => %w(141.1 141.2 141.3 141.4), '11' => %w(151.1 151.2 151.3 151.4),
                           '12' => %w(157.1 157.2 157.3 157.4 157.5 157.6 157.7 158)}

      points_by_week = week_data.keys.each_with_object({}) do |week, points_by_week|
        points_by_week[week] = week_data[week][participant['username']]
      end

      missing_by_week = points_by_week.keys.each_with_object({})  do |week, missing_by_week|
        weeks_points = points_by_week[week] || [] #palauttaa arrayn
        weeks_compulsory_points = compulsory_points[week] || []
        missing_by_week[week] = weeks_compulsory_points - weeks_points
      end

      str = ""
      missing_by_week.keys.each do |week|
        missing = missing_by_week[week]
        unless missing.nil? or missing.length == 0
          str << week
          str << ": "
          str << missing.join(",")
          str << "  "
        end
      end
      applicant.missing_points = str
    end
  end
end
