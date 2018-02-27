ActiveAdmin.register Submission do
  menu priority: 4, if: -> { current_admin_user.admin? }
  config.clear_action_items!
  config.batch_actions = false
  breadcrumb do
  end

  filter :status, as: :check_boxes, collection: Submission.statuses_for_select
  filter :form_name, label: 'Questionário', as: :select, collection: Form.all.map(&:name)
  filter :administration, label: 'Rede de Ensino', as: :select, collection: proc { Submission.all.map(&:administration).uniq }

  index do
    column :id
    column 'Escola', :school
    column 'Rede de Ensino', :administration
    column 'Amostra', :sample_school?
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
  end

  controller do
    before_action :check_auth

    def scoped_collection
      super.includes :school
    end

    def check_auth
      return if current_admin_user.admin?
      redirect_to admin_root_path, notice: (I18n.t 'errors.unauthorized')
    end
  end
end
