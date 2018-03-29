ActiveAdmin.register CollectEntry do
  menu priority: 7, if: -> { current_admin_user.admin? }
  permit_params :name, :adm_cod, :phase, :size, :sample_size, :school_inep,
                :school_sequence, :group, :collect_id
  config.batch_actions = false
  config.clear_action_items!
  config.sort_order = 'collect_id_asc'
  active_admin_import
  breadcrumb do
  end

  filter :name_cont, label: 'Nome'
  filter :adm_cod, label: 'Rede de Ensino', as: :select, collection: Administration.all
  filter :phase_cont, label: 'Período'
  filter :school_inep_cont, label: 'INEP da Escola'
  filter :collect, label: 'Coleta', as: :select, collection: Collect.all
  filter :group, label: '', as: :check_boxes, collection: %w[Amostra Repescagem]

  index do
    column :id
    column :name
    column "Rede de Ensino" do |collect_entry|
      collect_entry.administration.name
    end
    column :phase
    column :size
    column :sample_size
    column "Escola" do |collect_entry|
      collect_entry.school.name
    end
    column :school_sequence
    column :group
    column "Coleta" do |collect_entry|
      collect_entry.collect.name
    end
  end
  controller do
    before_action(only: :index) { check_auth }

    def check_auth
      return if current_admin_user.admin?
      redirect_to admin_root_path, notice: (I18n.t 'errors.unauthorized')
    end
  end
end
