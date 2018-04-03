ActiveAdmin.register Collect do
  menu priority: 5, if: -> { current_admin_user.admin? }
  permit_params :name, :phase, :form, :form_assembly_params, :deadline,
                :form_id, :status, form_sections: [], administration_ids: []
  config.batch_actions = false
  breadcrumb do
  end

  before_save do |collect|
    collect.form_assembly_params = collect.sections_to_form_assembly_params
  end

  filter :name_cont, label: 'Nome'
  filter :status, label: 'Status', as: :check_boxes,
    collection: Collect.statuses.collect { |k,v| [Collect.human_attribute_name(k), v]}
  filter :form_id, label: 'Questionário', as: :select,
    collection: Form.all

  index do
    column :id
    column :name
    column :phase
    column "Redes de ensino" do |collect|
      raw collect.administrations.map(&:name).join("<br>")
    end
    column :form do |collect|
      collect.form.name
    end
    column :parsed_form_sections
    column :deadline
    column :status do |collect|
      status = Collect.human_attribute_name(collect.status)
      status_tag "#{status}", label: status
    end
    actions
  end

  form title: 'Criar uma coleta' do |f|
    inputs do
      input :name
      input :phase
      input :administration_ids, as: :select, collection: Administration.all.order(:name), multiple: true, input_html: { size: 20 }
      input :status, as: :select, collection: Collect.statuses.collect { |k, _| [Collect.human_attribute_name(k), k] }
      input :form_id, label: 'Questionário', as: :select, collection: Form.all.map { |form| ["#{form.name}", form.id] }
      input :form_sections, as: :check_boxes, collection: %w[A B C D E F G H I J K L M N O]
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
