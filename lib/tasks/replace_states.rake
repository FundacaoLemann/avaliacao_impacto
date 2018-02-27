namespace :db do
  desc 'Replace all states with the provided file'
  task replace_states: :environment do
    puts 'Destroying all states'
    State.destroy_all
    CSV.foreach('lib/assets/states.csv', headers: true) do |row|
      puts "Creating state #{row}"
      State.create(id: row[0], name: row[1], acronym: row[2])
    end
    puts 'Done!'
  end
end
