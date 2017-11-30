ActiveAdmin.register School do
  menu label: 'Escolas'
  active_admin_import
  batch_action :destroy, false
  permit_params :inep, :name, :tp_dependencia, :tp_dependencia_desc, :cod_municipio,
    :municipio, :unidade_federativa, :num_estudantes, :ano_censo, :sample

  scope("Amostra") { |school| school.where(sample: true) }
  scope("Amostra e não iniciadas") { |school| school.where(sample: true).includes(:submissions).where(submissions: { school_id: nil }) }

  filter :id_cont, label: 'id'
  filter :inep_cont, label: 'INEP'
  filter :name_cont, label: 'Nome'
  filter :tp_dependencia_desc, as: :select, collection: %w[Estadual Municipal Federal], label: 'Rede de ensino'
  filter :unidade_federativa_cont, label: 'Estado'
  filter :municipio_cont, label: 'Cidade'
  filter :cod_municipio_cont, label: 'Código IBGE'
  filter :submissions_status, label: 'Status', as: :check_boxes, collection: Submission::STATUSES

  index title: 'Escolas' do
    selectable_column
    id_column
    column :inep
    column 'Nome da escola', :name
    column 'Rede de ensino', :tp_dependencia_desc
    column :unidade_federativa
    column :municipio
    column 'Status' do |school|
      school.submissions.first.parsed_status if school.submissions.any?
    end
    column 'Telefone da escola' do |school|
      school.submissions.first.school_phone if school.submissions.any?
    end
    column 'Telefone do gestor' do |school|
      school.submissions.first.submitter_phone if school.submissions.any?
    end
    column 'Nome do gestor' do |school|
      school.submissions.first.submitter_name if school.submissions.any?
    end

  end

  batch_action :adicionar_na_amostra, confirm: "Confirme a ação" do |ids|
    batch_action_collection.find(ids).each do |school|
      school.update(sample: true)
    end
    redirect_to collection_path, alert: "As escolas foram inseridas na amostra"
  end

  batch_action :remover_da_amostra, confirm: "Confirme a ação" do |ids|
    batch_action_collection.find(ids).each do |school|
      school.update(sample: false)
    end
    redirect_to collection_path, alert: "As escolas foram removidas da amostra"
  end

  controller do
    def scoped_collection
      super.includes :submissions
    end
  end
end
