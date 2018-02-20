ActiveAdmin.register Form do
  menu priority: 9, if: -> { current_admin_user.admin? }
  permit_params :name, :link
  config.batch_actions = false
  breadcrumb do
  end

  filter :name_cont, label: 'Nome do Formulário'
  filter :link_cont

  controller do
    before_action :check_auth

    def check_auth
      return if current_admin_user.admin?
      redirect_to admin_root_path, notice: (I18n.t 'errors.unauthorized')
    end
  end
end
