ActiveAdmin.register School do
  menu label: "Escolas"
  active_admin_import
  filter :unidade_federativa, label: 'Estado'
  filter :municipio, label: 'Cidade'
  filter :tp_dependencia_desc, label: 'Rede de ensino'
  filter :name, label: 'Nome'
  filter :inep

  index do
    column :inep
    column 'Nome da escola', :name
    column 'Rede de ensino', :tp_dependencia_desc
    column :unidade_federativa
    column :municipio
    actions
  end
end
