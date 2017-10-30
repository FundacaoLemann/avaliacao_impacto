ActiveAdmin.register FormOption do
  permit_params :dependencia_desc, :state_or_city, {sections_to_show: []}

  before_save do |form_option|
    form_option.form_assembly_params = form_option.sections_to_form_assembly_params
  end

  filter :dependencia_desc, label: 'Rede de ensino'
  filter :state_or_city, label: 'Estado ou cidade'

  index do
    column 'Seções habilitadas', :sections_to_show
    column 'Rede de ensino', :dependencia_desc
    column :state_or_city
    actions
  end

  form title: 'Inserir opções de seções por rede de ensino' do |f|
    inputs do
      input :dependencia_desc, as: :select, collection: %w[Estadual Municipal], label: 'Rede de ensino'
      input :state_or_city, label: 'Estado ou municipio'
      input :sections_to_show, as: :check_boxes, collection: %w[A B C D E F], label: 'Habilitar seções'
    end

    actions
  end
end
