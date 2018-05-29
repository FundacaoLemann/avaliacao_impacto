namespace :db do
  desc "Create schools from a csv file"
  task import_schools: :environment do
    School.transaction do
      CSV.foreach("lib/assets/base_escolas_preditores.csv", headers: true) do |row|
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
          adm_cod: row[9],
          region: row[10],
          num_students_fund: row[11],
          location: row[12]
        )
      end
    end
    p "Done!"
  end
end
