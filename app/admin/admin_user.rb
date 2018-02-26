ActiveAdmin.register AdminUser do
  menu priority: 9, if: -> { current_admin_user.sub_admin? }
  permit_params :email, :password, :password_confirmation, :role
  config.batch_actions = false
  breadcrumb do
  end
  index do
    selectable_column
    id_column
    column :email
    column :role do |admin_user|
      AdminUser.human_attribute_name(admin_user.role)
    end
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email_cont, label: 'Email'
  filter :role, as: :select,
    collection: AdminUser.roles.collect {|k, v| [AdminUser.human_attribute_name(k), v]}

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role, as: :select, collection: AdminUser.roles.collect { |k, _| [AdminUser.human_attribute_name(k), k] }
    end
    f.actions
  end

  controller do
    before_action :check_auth

    def check_auth
      return if current_admin_user.sub_admin?
      redirect_to admin_root_path, notice: (I18n.t 'errors.unauthorized')
    end
  end
end
