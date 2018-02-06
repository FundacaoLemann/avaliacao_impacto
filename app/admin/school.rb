ActiveAdmin.register School do
  menu label: 'Relatório detalhado', priority: 0
  active_admin_import
  batch_action :destroy, false
  permit_params :inep, :name, :tp_dependencia, :tp_dependencia_desc, :cod_municipio,
    :municipio, :unidade_federativa, :num_estudantes, :ano_censo, :sample

  breadcrumb do
  end
  scope("Amostra") { |school| school.where(sample: true) }
  scope("Amostra e não iniciadas") { |school| school.where(sample: true).includes(:submissions).where(submissions: { school_id: nil }) }

  filter :inep_cont, label: 'INEP'
  filter :name_cont, label: 'Nome'
  filter :tp_dependencia_desc, as: :select, collection: %w[Estadual Municipal Federal], label: 'Rede de ensino'
  filter :unidade_federativa_cont, label: 'Estado'
  filter :municipio_cont, label: 'Municipio'
  filter :submissions_status, label: 'Status das escolas que já iniciaram', as: :check_boxes, collection: Submission::STATUSES

  index title: 'Relatório detalhado' do
    selectable_column
    column 'Amostra', :sample
    column :inep
    column 'Nome da escola', :name
    column 'Rede de ensino', :tp_dependencia_desc
    column 'Estado', :unidade_federativa
    column :municipio
    column 'Status' do |school|
      if school.submissions.any?
        status = school.submissions.first.parsed_status
        status_tag "#{status}", label: status
      end
    end
    column 'Data de atualização do último status' do |school|
      if school.submissions.any?
        school.submissions.first.parsed_status_date
      end
    end
    column 'Telefone da escola' do |school|
      school.submissions.last.school_phone if school.submissions.any?
    end
    column 'Telefone do gestor' do |school|
      school.submissions.last.submitter_phone if school.submissions.any?
    end
    column 'Nome do gestor' do |school|
      school.submissions.last.submitter_name if school.submissions.any?
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
