namespace :db do
  desc 'Replace all cities with the provided file'
  task replace_cities: :environment do
    puts 'Destroying all cities'
    City.destroy_all
    CSV.foreach('lib/assets/cities.csv', headers: true) do |row|
      puts "Creating city #{row}"
      City.create(ibge_code: row[0], name: row[1], state_id: row[2])
    end
    puts 'Done!'
  end
end
