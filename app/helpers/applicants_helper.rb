module ApplicantsHelper
  def format_week_percents(percent)
    if percent.nil?
      return raw "NULL"
    end
    if percent >= 90
      raw "<span class=\"completed\">#{number_to_human(percent)}%</span>"
    else
      raw "<span class=\"not-yet\">#{number_to_human(percent)}%</span>"
    end
  end

  $all_values = ["Alkeis- ja viittaustyyppiset muuttujat","Javan API ja PrintWriter","Koodin parantelua","Koodin siistintä ja viittaustyyppiset muuttujat","Lahjakortit","Lentokoneista, luokista ja olioista","Linkitetyt metrojunat","Luokat ja oliot","Luokka SaaEnnustaja","Metodit ja parametrit","Mikä ihmeen List?","Mistä nyt oikein on kyse: this?","Muuttujat ja toistolausekkeet","Muuttujat, parametrit, metodit, ...","Oliotermistöä","Perinnästä","Polymorfismi","Rajapintojen hyötyjä","Rakkautta rinnassa","Single Responsibility Principle ja Refaktorointi","Staattiset ja ei-staattiset metodit","Summa summarum","Tarkkailija","Toiston toistoa","Vanha koe","Vanha ohjan koe I","Vanha ohjan koe II"]

  def list_explanations(explanations)
    explanations ||= []
    retval = []
    $all_values.each do |a|
      if explanations.include? a
        retval << "<span class=\"completed\">#{a}</span>"
      else
        retval << "<span class=\"not-yet\">#{a}</span>"
      end
    end
    raw retval.join(" ")
  end

  def sortable_model_name(attr)
    Applicant.human_attribute_name(attr)

    #link_to Applicant.human_attribute_name(attr), applicants_path(sort_by: attr)
  end
end
