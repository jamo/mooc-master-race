json.array!(@applicants) do |applicant|
  json.email applicant.email
end
