require 'httparty'
class TmcConnection

  def download!
    #Rails.cache.fetch('user_info', { data: user_info.clone, week_data: week_data.dup, time: Time.now})
    # TODO(jamo): make course configurable
    Rails.cache.fetch('user_info', expires_in: 5.minutes) do
      auth = {username: Settings.tmc_username, password: Settings.tmc_password}
      url = "https://tmc.mooc.fi/mooc/participants.json?api_version=7&utf8=%E2%9C%93&filter_koko_nimi=&column_username=1&column_email=1&column_koko_nimi=1&column_hakee_yliopistoon_2015=1&group_completion_course_id=27"
      user_info = JSON.parse(HTTParty.get(url, basic_auth: auth).body)['participants']
      week_data = fetch_week_datas(auth)
      { data: user_info.clone, week_data: week_data.dup, time: Time.now}
    end
  end

  private
  def fetch_week_datas(auth)
    base_url = "https://tmc.mooc.fi/mooc/courses/27/points/"
    weeks = %w(1 2 3 4 5 6 7 8 9 10 11 12 13 14)
    rest = ".json?api_version=7"
    week_data = {}
    weeks.each do |week|
      week_data[week] = JSON.parse(HTTParty.get(base_url + week + rest, basic_auth: auth).body)['users_to_points']
    end
    week_data
  end
end
