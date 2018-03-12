namespace :db do
  desc 'Update schools from 2017 data'
  task update_schools_2017: :environment do
    CSV.foreach('lib/assets/schools_2017.csv', headers: true) do |row|
      school = School.find_by_inep(row[0])
      if school
        puts "Updating school #{school}"
        school.update(
          name: row[1],
          tp_dependencia: row[2],
          tp_dependencia_desc: row[3],
          cod_municipio: row[4],
          municipio: row[5],
          unidade_federativa: row[6],
          num_estudantes: row[7],
          ano_censo: row[8],
          adm_cod: row[9]
        )
      else
        puts "Creating school #{row}"
        School.create(
          inep: row[0],
          name: row[1],
          tp_dependencia: row[2],
          tp_dependencia_desc: row[3],
          cod_municipio: row[4],
          municipio: row[5],
          unidade_federativa: row[6],
          num_estudantes: row[7],
          ano_censo: row[8],
          adm_cod: row[9]
        )
      end
    end
    puts 'Done!'
  end
end
