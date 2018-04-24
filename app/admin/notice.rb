ActiveAdmin.register Notice do
  menu priority: 13, if: -> { current_admin_user.admin? }
  permit_params :content
  config.clear_action_items!
  config.filters = false
  actions :all, except: [:destroy, :show]

  index do
    column "Texto" do |notice|
      raw notice.content
    end
    column :updated_at

    actions
  end

  form title: "Criar aviso inicial" do |f|
    inputs do
      input :content, as: :medium_editor
    end

    actions
  end
end
