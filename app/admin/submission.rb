include ActiveAdmin::ViewsHelper
ActiveAdmin.register Submission do
  menu priority: 1, parent: "Relatórios", if: -> { current_admin_user.admin? }
  config.clear_action_items!
  actions :all, except: [:show, :edit]

  filter :status, as: :check_boxes, collection: Submission.statuses_for_select
  filter :administration, label: i18n_for("submission", "adm_cod"),
    as: :select, collection: Administration.all
  filter :collect, label: i18n_for("submission", "collect_id"),
    as: :select, collection: Collect.all

  index do
    column :id
    column i18n_for("submission", "collect_id") do |submission|
      submission.collect.name if submission.collect
    end
    column i18n_for("submission", "school_inep") do |submission|
      submission.school.name
    end
    column i18n_for("submission", "group") do |submission|
      submission.collect_entry.group if submission.collect_entry
    end
    column i18n_for("submission", "adm_cod") do |submission|
      submission.administration.name
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
