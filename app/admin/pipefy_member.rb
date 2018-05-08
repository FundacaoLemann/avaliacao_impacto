ActiveAdmin.register Pipefy::Member do
  menu priority: 14, if: -> { current_admin_user.admin? }
  permit_params :pipefy_id, :name, :email
  config.batch_actions = false
  config.filters = false
  breadcrumb do
  end

  form title: "Criar membro do pipefy" do |f|
    inputs do
      input :pipefy_id, label: "Id no pipefy"
      input :name
      input :email
    end

    actions
  end
end
