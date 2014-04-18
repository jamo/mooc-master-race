module ApplicantsHelper
  def format_week_percents(percent)
    if percent >= 85
      raw "<span class=\"completed\">#{number_to_human(percent)}%</span>"
    else
      raw "<span class=\"not-yet\">#{number_to_human(percent)}%</span>"
    end
  end

  def sortable_model_name(attr)
    Applicant.human_attribute_name(attr)

    #link_to Applicant.human_attribute_name(attr), applicants_path(sort_by: attr)
  end
end
