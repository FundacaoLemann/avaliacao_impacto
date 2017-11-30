ActiveAdmin.register School do
  menu label: "Escolas"
  active_admin_import
  permit_params :inep, :name, :tp_dependencia, :tp_dependencia_desc, :cod_municipio,
    :municipio, :unidade_federativa, :num_estudantes, :ano_censo
  filter :id_cont, label: 'id'
  filter :inep_cont, label: 'INEP'
  filter :name_cont, label: 'Nome'
  filter :tp_dependencia_desc, as: :select, collection: %w[Estadual Municipal Federal], label: 'Rede de ensino'
  filter :unidade_federativa_cont, label: 'Estado'
  filter :municipio_cont, label: 'Cidade'
  filter :cod_municipio_cont, label: 'Código IBGE'

  index do
    column :id
    column :inep
    column 'Nome da escola', :name
    column 'Rede de ensino', :tp_dependencia_desc
    column :unidade_federativa
    column :municipio
    column 'Código IBGE do municipio', :cod_municipio
    actions
  end
end
