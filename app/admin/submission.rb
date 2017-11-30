ActiveAdmin.register Submission do
  config.clear_action_items!
  menu priority: 4
  filter :status, as: :check_boxes, collection: Submission::STATUSES
  filter :form_name, label: 'Questionário', as: :select, collection: %w[baseline follow_up]
  filter :administration, label: 'Rede de Ensino', as: :select, collection: proc { Submission.all.map(&:administration).uniq }

  index do
    column :id
    column 'Escola', :school
    column 'Rede de Ensino', :administration
    column 'Amostra', :sample_school?
    column 'Questionário', :form_name
    column 'Status', :parsed_status
    column 'Telefone da escola', :school_phone
    column 'Nome do gestor', :submitter_name
    column 'Email do gestor', :submitter_email
    column 'Telefone do gestor', :submitter_phone
    column 'Data de redirecionamento', :redirected_at_parsed
    column 'Data de salvamento', :saved_at_parsed
    column 'Data de submissão', :submitted_at_parsed
  end

  controller do
    def scoped_collection
      super.includes :school
    end
  end
end
