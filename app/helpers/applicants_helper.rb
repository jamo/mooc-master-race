module ApplicantsHelper
  def format_week_percents(percent)
    if percent >= 85
      raw "<span class=\"completed\">#{number_to_human(percent)}%</span>"
    else
      raw "<span class=\"not-yet\">#{number_to_human(percent)}%</span>"
    end
  end
end
