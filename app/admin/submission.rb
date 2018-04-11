ActiveAdmin.register Submission do
  menu priority: 1, parent: "Relatórios", if: -> { current_admin_user.admin? }
  config.clear_action_items!
  config.batch_actions = false
  breadcrumb do
  end

  filter :status, as: :check_boxes, collection: Submission.statuses_for_select
  filter :administration, label: 'Rede de Ensino', as: :select, collection: Administration.all
  filter :collect, label: 'Coleta', as: :select, collection: Collect.all

  index do
    column :id
    column 'Coleta' do |submission|
      submission.collect.name if submission.collect
    end
    column 'Escola' do |submission|
      submission.school.name
    end
    column 'Grupo' do |submission|
      submission.collect_entry.group if submission.collect_entry
    end
    column 'Rede de Ensino' do |submission|
      submission.administration.name
    end
    column 'Questionário', :form_name
    column 'Status' do |submission|
      status = Submission.human_attribute_name(submission.status)
      status_tag "#{status}", label: status
     end
    column 'Telefone da escola', :school_phone
    column 'Nome do gestor', :submitter_name
    column 'Email do gestor', :submitter_email
    column 'Telefone do gestor', :submitter_phone
    column 'Data de redirecionamento', :redirected_at_parsed
    column 'Data de salvamento', :saved_at_parsed
    column 'Data de submissão', :submitted_at_parsed
    column :card_id
  end

  controller do
    before_action :check_auth

    def scoped_collection
      super.includes :school, :administration
    end

    def check_auth
      return if current_admin_user.admin?
      redirect_to admin_root_path, notice: (I18n.t 'errors.unauthorized')
    end
  end
end
