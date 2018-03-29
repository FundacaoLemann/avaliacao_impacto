namespace :submission do
  task update_submissions: :environment do
    puts "Update administration codes"
    Submission.where(adm_cod: "Rede Estadual de Alagoas").update_all(adm_cod: "2-27")
    Submission.where(adm_cod: "Rede Estadual de Amazonas").update_all(adm_cod: "2-13")
    Submission.where(adm_cod: "Rede Estadual de Goiás").update_all(adm_cod: "2-52")
    Submission.where(adm_cod: "Rede Estadual de Maranhão").update_all(adm_cod: "2-21")
    Submission.where(adm_cod: "Rede Estadual de Mato Grosso do Sul").update_all(adm_cod: "2-50")
    Submission.where(adm_cod: "Rede Estadual de Piauí").update_all(adm_cod: "2-22")
    Submission.where(adm_cod: "Rede Estadual de Rio de Janeiro").update_all(adm_cod: "2-33")
    Submission.where(adm_cod: "Rede Estadual de Rio Grande do Norte").update_all(adm_cod: "2-24")
    Submission.where(adm_cod: "Rede Estadual de Roraima").update_all(adm_cod: "2-14")
    Submission.where(adm_cod: "Rede Estadual de Sergipe").update_all(adm_cod: "2-28")
    Submission.where(adm_cod: "Rede Federal de Ensino do Brasil").update_all(adm_cod: "1")
    Submission.where(adm_cod: "Rede Municipal de Abatiá").update_all(adm_cod: "3-4100103")
    Submission.where(adm_cod: "Rede Municipal de Afonso Cláudio").update_all(adm_cod: "3-3200102")
    Submission.where(adm_cod: "Rede Municipal de Alvarães").update_all(adm_cod: "3-1300029")
    Submission.where(adm_cod: "Rede Municipal de Anori").update_all(adm_cod: "3-1300102")
    Submission.where(adm_cod: "Rede Municipal de Campina Grande").update_all(adm_cod: "3-2504009")
    Submission.where(adm_cod: "Rede Municipal de Campos do Jordão").update_all(adm_cod: "3-3509700")
    Submission.where(adm_cod: "Rede Municipal de Castro").update_all(adm_cod: "3-4104907")
    Submission.where(adm_cod: "Rede Municipal de Cataguases").update_all(adm_cod: "3-3115300")
    Submission.where(adm_cod: "Rede Municipal de Franca").update_all(adm_cod: "3-3516200")
    Submission.where(adm_cod: "Rede Municipal de Francisco Morato").update_all(adm_cod: "3-3516309")
    Submission.where(adm_cod: "Rede Municipal de Guaratinguetá").update_all(adm_cod: "3-3518404")
    Submission.where(adm_cod: "Rede Municipal de Guarulhos").update_all(adm_cod: "3-3518800")
    Submission.where(adm_cod: "Rede Municipal de Itaguaí").update_all(adm_cod: "3-3302007")
    Submission.where(adm_cod: "Rede Municipal de Juazeiro do Norte").update_all(adm_cod: "3-2307304")
    Submission.where(adm_cod: "Rede Municipal de Manaus").update_all(adm_cod: "3-1302603")
    Submission.where(adm_cod: "Rede Municipal de Novo Gama").update_all(adm_cod: "3-5215231")
    Submission.where(adm_cod: "Rede Municipal de Ponta Grossa").update_all(adm_cod: "3-4119905")
    Submission.where(adm_cod: "Rede Municipal de Porto Velho").update_all(adm_cod: "3-1100205")
    Submission.where(adm_cod: "Rede Municipal de Ribeirão Preto").update_all(adm_cod: "3-3543402")
    Submission.where(adm_cod: "Rede Municipal de São José dos Campos").update_all(adm_cod: "3-3549904")
    Submission.where(adm_cod: "Rede Municipal de São Luís").update_all(adm_cod: "3-2111300")
    Submission.where(adm_cod: "Rede Municipal de São Paulo").update_all(adm_cod: "3-3550308")
    Submission.where(adm_cod: "Rede Municipal de Taubaté").update_all(adm_cod: "3-3554102")
    puts 'Done!'
    puts 'Updating school ineps'
    Submission.find_each do |submission|
      school = School.find(submission.school_id)
      submission.update_attribute("school_inep", school.inep)
    end
    puts 'Done!'
  end
end
