ActiveAdmin.register FormOption do
  menu priority: 4, if: -> { current_admin_user.admin? }
  permit_params :form_name, :dependencia_desc, :state_or_city, :deadline, {sections_to_show: []}
  menu priority: 4
  config.batch_actions = false
  breadcrumb do
  end
  before_save do |form_option|
    form_option.form_assembly_params = form_option.sections_to_form_assembly_params
  end

  filter :form_name, label: 'Questionário', as: :select,
    collection: FormOption.form_names_for_select
  filter :dependencia_desc, as: :select, collection: %w[Estadual Municipal Federal], label: 'Rede de ensino'
  filter :state_or_city_cont, label: 'Código IBGE do Estado ou cidade'

  index do
    column 'Questionário' do |form_option|
      FormOption.human_attribute_name(form_option.form_name)
    end
    column 'Seções habilitadas', :sections_to_show
    column 'Rede de ensino', :dependencia_desc
    column 'Estado ou cidade', :name_state_or_city
    column 'Prazo de entrega', :deadline
    actions
  end

  form title: 'Inserir opções de seções por rede de ensino' do |f|
    inputs do
      input :form_name, as: :select, label: 'Questionário',
        collection: FormOption.form_names_for_select
      input :dependencia_desc, as: :select, collection: %w[Estadual Municipal], label: 'Rede de ensino'
      input :state_or_city, label: 'Código ibge do estado ou municipio'
      input :sections_to_show, as: :check_boxes, collection: %w[A B C D E F], label: 'Habilitar seções'
      input :deadline, as: :datepicker, datepicker_options: { dateFormat: 'dd/mm/yy' }
    end

    actions
  end

  controller do
    # this skip is for the search action on administration.js
    skip_before_action :authenticate_active_admin_user, if: -> { request.format.json? }
    before_action(only: :index) { check_auth }

    def check_auth
      return if current_admin_user.admin?
      redirect_to admin_root_path, notice: (I18n.t 'errors.unauthorized')
    end
  end
end
