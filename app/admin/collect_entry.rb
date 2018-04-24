include ActiveAdmin::ViewsHelper
ActiveAdmin.register CollectEntry do
  menu priority: 4, parent: "Gerenciar Coletas", if: -> { current_admin_user.admin? }
  permit_params :name, :adm_cod, :phase, :size, :sample_size, :school_inep,
    :school_sequence, :group, :collect_id, :card_id, :substitute, :quitter, :member_email
  config.clear_action_items!
  config.sort_order = "collect_id_asc"
  active_admin_import

  filter :name_cont, label: i18n_for("collect_entry", "name")
  filter :administration, label: i18n_for("collect_entry", "adm_cod"),
    as: :select, collection: Administration.all
  filter :phase_cont, label: i18n_for("collect_entry", "phase")
  filter :school_inep_cont, label: i18n_for("collect_entry", "inep")
  filter :collect, label: i18n_for("collect_entry", "collect_id"),
    as: :select, collection: Collect.all
  filter :group, label: "", as: :check_boxes, collection: %w[Amostra Repescagem]

  index do
    column :id
    column :name
    column i18n_for("collect_entry", "adm_cod") do |collect_entry|
      collect_entry.administration.name
    end
    column :phase
    column :size
    column :sample_size
    column i18n_for("collect_entry", "school_inep") do |collect_entry|
      collect_entry.school.name
    end
    column :school_sequence
    column :group
    column i18n_for("collect_entry", "collect_id") do |collect_entry|
      collect_entry.collect.name
    end
    column :substitute
    column :quitter
    column :card_id
    column :member_email
    actions
  end

  form do |f|
    inputs do
      input :name
      input :adm_cod, as: :string
      input :phase
      input :size
      input :sample_size
      input :school_inep, as: :string
      input :school_sequence
      input :group
      input :collect
      input :card_id
<<<<<<< HEAD
      input :member_email
=======
      input :substitute
      input :quitter
>>>>>>> 71c147b... Fix rubocop issues on Active Admin pages
    end
    actions
  end

  controller do
    before_action(only: :index) { check_auth }

    def check_auth
      return if current_admin_user.admin?
      redirect_to admin_root_path, notice: I18n.t("errors.unauthorized")
    end
  end
end
