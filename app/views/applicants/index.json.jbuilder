json.array!(@applicants) do |applicant|
  json.extract! applicant, :id, :name, :nick, :email
  json.url applicant_url(applicant, format: :json)
end
