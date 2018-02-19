ActiveAdmin.register Stratum do
  menu priority: 7, if: -> { current_admin_user.admin? }
  permit_params :name, :administration, :phase, :size, :sample_size, :school,
                :school_sequence, :group
  config.batch_actions = false
  active_admin_import
  breadcrumb do
  end

  filter :name_cont, label: 'Nome'
  filter :administration_cont, label: 'Rede de Ensino'
  filter :phase_cont, label: 'Período'
  filter :school_cont, label: 'INEP'
  filter :group, label: '', as: :check_boxes, collection: %w[Amostra Repescagem]

  controller do
    before_action(only: :index) { check_auth }

    def check_auth
      return if current_admin_user.admin?
      redirect_to admin_root_path, notice: (I18n.t 'errors.unauthorized')
    end
  end
end
