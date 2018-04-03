ActiveAdmin.register School do
  menu priority: 11, if: -> { current_admin_user.sub_admin? }

  permit_params :inep, :name, :tp_dependencia, :tp_dependencia_desc, :cod_municipio,
    :municipio, :unidade_federativa, :num_estudantes, :ano_censo, :adm_cod

  config.batch_actions = false
  config.clear_action_items!
  active_admin_import
  config.sort_order = 'inep_asc'
  breadcrumb do
  end

  filter :inep_cont, label: 'INEP'
  filter :name_cont, label: 'Nome'
  filter :unidade_federativa_cont, label: 'Estado'
  filter :municipio_cont, label: 'Municipio'
  filter :tp_dependencia_desc, label: '',
    as: :check_boxes, collection: %w[Estadual Federal Municipal Privada]

  index do
    column :inep
    column :name
    column 'Rede de Ensino' do |school|
      school.administration.name unless school.administration.blank?
    end
    column :municipio
    column :unidade_federativa
    column :tp_dependencia_desc
    column :num_estudantes
    column :ano_censo
  end
end
