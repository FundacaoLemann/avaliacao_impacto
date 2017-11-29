ActiveAdmin.register Submission do
  config.clear_action_items!
  filter :status, as: :select, collection: %w[redirected in_progress submitted]
  filter :form_name, label: 'Questionário', as: :select, collection: %w[baseline follow_up]
  filter :administration, label: 'Rede de Ensino', as: :select, collection: Submission.all.map(&:administration).uniq

  index do
    column 'Escola', :school
    column 'Rede de Ensino', :administration
    column 'Questionário', :form_name
    column :status
    column 'Telefone da escola', :school_phone
    column 'Nome do responsável', :submitter_name
    column 'Email do responsável', :submitter_email
    column 'Telefone do responsável', :submitter_phone
    column 'Data de redirecionamento', :redirected_at
    column 'Data de salvamento', :saved_at
    column 'Data de submissão', :submitted_at
  end

  controller do
    def scoped_collection
      super.includes :school
    end
  end
end
