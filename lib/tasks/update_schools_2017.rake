namespace :db do
  desc "Update schools with the extra fields"
  task update_schools: :environment do
    not_found_schools = []
    School.transaction do
      CSV.foreach("lib/assets/school_new_fields.csv", headers: true) do |row|
        school = School.find_by_inep(row[0])
        if school
          puts "Updating school #{school}"
          school.update(
            region: row[1],
            num_students_fund: row[2],
            location: row[3]
          )
        else
          not_found_schools << row
        end
      end
    end
    p 'Done!'
    p 'Not found schools'
    p not_found_schools
  end
end
