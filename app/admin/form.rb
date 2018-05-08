include ActiveAdmin::ViewsHelper
ActiveAdmin.register Form do
  menu priority: 1, parent: "Gerenciar Coletas", if: -> { current_admin_user.admin? }
  permit_params :name, :link

  filter :name_cont, label: i18n_for("form", "name")

  controller do
    before_action :check_auth

    def check_auth
      return if current_admin_user.admin?
      redirect_to admin_root_path, notice: I18n.t("errors.unauthorized")
    end
  end
end
