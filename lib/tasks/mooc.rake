namespace :mooc do
  desc "Import data from mooc participants list"
  task import: :environment do
    source_file = ENV.fetch("FILE")
    puts source_file

    fields = %i(last_name preferred_name email phone mooc eligible).freeze
    IO.readlines(source_file).each do |line|
      data = fields.zip(line.chomp.split(",")).to_h
      data[:mooc] = !data[:mooc].blank?
      data[:eligible] = data[:eligible] != "ei"
      user = ImportedUser.create!(data)
      puts user
    end

  end

  desc "Match data"
  task match: :environment do
    a = 0
    b = 0
    puts ImportedUser.where(mooc: true).count
    ImportedUser.where(mooc: true).find_each do |imported|
      applicant = Applicant.find_by(email: imported.email)
      if applicant
        a+=1
        puts "#{applicant.email} #{imported.email}"
        imported.applicant = applicant
        applicant.phone_number = imported.phone
        applicant.save!
        imported.save!
      else
        b+=1
      end
    end
    puts a
    puts b

  end
end

