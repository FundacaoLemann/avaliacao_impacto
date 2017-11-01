ActiveAdmin.register Submission do
  filter :school, label: 'Escola'
  filter :status

  index do
    column 'Escola', :school
    column :status
    column 'Telefone da escola', :school_phone
    column 'Nome do responsável', :submitter_name
    column 'Email do responsável', :submitter_email
    column 'Telefone do responsável', :submitter_phone
    column 'Data de redirecionamento', :redirected_at
    actions
  end
end
