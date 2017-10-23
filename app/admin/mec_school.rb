ActiveAdmin.register MecSchool do
  menu label: "Escolas MEC"
  active_admin_import
  permit_params :inep, :name
  actions :index
  filter :unidade_federativa, label: 'Estado'
  filter :municipio, label: 'Cidade'
  filter :tp_dependencia_desc, label: 'Administração'
  filter :name, label: 'Nome'
  filter :inep

  index do
    column :id
    column :inep
    column :name
    column :tp_dependencia_desc
    column :unidade_federativa
    column :municipio
    column 'Link para formulário'
  end
end
