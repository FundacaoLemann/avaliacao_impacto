ActiveAdmin.register Collect do
  menu priority: 6, if: -> { current_admin_user.admin? }
  permit_params :name, :phase, :form, :form_assembly_params, :deadline,
                :administrations_raw, form_sections: []
  config.batch_actions = false
  breadcrumb do
  end

  filter :name_cont, label: 'Nome'
  filter :phase_cont, label: 'Período'
  filter :form_id, label: 'Questionário', as: :select,
    collection: Form.all

  index do
    column :name
    column :phase
    column :parsed_administrations do |collect|
      raw collect.parsed_administrations
    end
    column :form do |collect|
      collect.form.name
    end
    column :parsed_form_sections
    column :deadline
    actions
  end

  form title: 'Criar uma coleta' do |f|
    inputs do
      input :name
      input :phase
      input :administrations_raw, as: :text
      input :form_id, label: 'Formulário', as: :select, collection: Form.all.map { |form| ["#{form.name}", form.id] }
      input :form_sections, as: :check_boxes, collection: %w[A B C D E F]
      input :deadline, as: :datepicker, datepicker_options: { dateFormat: 'dd/mm/yy' }
    end

    actions
  end

  controller do
    before_action(only: :index) { check_auth }

    def check_auth
      return if current_admin_user.admin?
      redirect_to admin_root_path, notice: (I18n.t 'errors.unauthorized')
    end
  end
end
