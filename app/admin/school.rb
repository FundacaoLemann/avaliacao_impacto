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
    column 'Código IBGE do municipio', :cod_municipio
    column 'Amostra', :sample
    column 'Status', :submission_status
    actions
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
