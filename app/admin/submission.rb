include ActiveAdmin::ViewsHelper
ActiveAdmin.register Submission do
  menu priority: 1, parent: "Relatórios", if: -> { current_admin_user.admin? }
  config.clear_action_items!
  actions :all, except: [:show]

  permit_params :school_inep, :adm_cod, :status, :school_phone, :submitter_name,
    :submitter_email, :submitter_phone, :response_id, :redirected_at, :saved_at,
    :modified_at, :submitted_at, :collect_id, :collect_entry_id, :card_id

  filter :school_inep_cont, label: i18n_for("submission", "school_inep")
  filter :status, as: :check_boxes, collection: Submission.statuses_for_select
  filter :administration, label: i18n_for("submission", "adm_cod"),
    as: :select, collection: proc { Administration.all }
  filter :collect, label: i18n_for("submission", "collect_id"),
    as: :select, collection: proc { Collect.all }

  index do
    column :id
    column i18n_for("submission", "collect_id") do |submission|
      submission.collect.name if submission.collect
    end
    column i18n_for("submission", "school_inep") do |submission|
      submission.school.to_s
    end
    column i18n_for("submission", "group") do |submission|
      submission.collect_entry.group if submission.collect_entry
    end
    column i18n_for("submission", "adm_cod") do |submission|
      submission.administration.name if submission.administration
    end
    column i18n_for("submission", "form_name"), :form_name
    column i18n_for("submission", "status") do |submission|
      status = Submission.human_attribute_name(submission.status) if submission.status
      status_tag "#{status}", label: status
    end
    column :school_phone
    column :submitter_name
    column :submitter_email
    column :submitter_phone
    column :redirected_at_parsed
    column :saved_at_parsed
    column :submitted_at_parsed
    actions
  end

  form do |f|
    inputs do
      input :school_inep, as: :string
      input :adm_cod, as: :string
      input :status
      input :school_phone
      input :submitter_name
      input :submitter_email
      input :submitter_phone
      input :response_id
      input :redirected_at, as: :datepicker, datepicker_options: { dateFormat: "dd/mm/yy" }
      input :saved_at, as: :datepicker, datepicker_options: { dateFormat: "dd/mm/yy" }
      input :modified_at, as: :datepicker, datepicker_options: { dateFormat: "dd/mm/yy" }
      input :submitted_at, as: :datepicker, datepicker_options: { dateFormat: "dd/mm/yy" }
      input :collect_id, as: :select, collection: Collect.all
      input :collect_entry_id
      input :card_id
    end
    actions
  end

  csv do
    column(:coleta) { |submission| submission.collect.name if submission.collect }
    column(:escola) { |submission| submission.school.to_s }
    column(:group) { |submission| submission.collect_entry.group if submission.collect_entry }
    column(:adm_cod) { |submission| submission.administration.name }
    column :form_name
    column(:status) { |submission| Submission.human_attribute_name(submission.status) if submission.status }
    column :school_phone
    column :submitter_name
    column :submitter_email
    column :submitter_phone
    column :redirected_at_parsed
    column :saved_at_parsed
    column :submitted_at_parsed
  end

  controller do
    before_action :check_auth

    def scoped_collection
      super.includes :school, :administration
    end

    def check_auth
      return if current_admin_user.admin?
      redirect_to admin_root_path, notice: I18n.t("errors.unauthorized")
    end
  end
end
