include ActiveAdmin::ViewsHelper
ActiveAdmin.register Contact do
  menu priority: 15, if: -> { current_admin_user.admin? }
  config.clear_action_items!

  active_admin_import batch_size: 100000,
    template_object: ActiveAdminImport::Model.new(
      force_encoding: :auto,
      send_to_pipefy: false,
    ),
    before_batch_import: proc { |import|
      import.headers['collect_id'] = 'collect_id'
      import.headers['send_to_pipefy'] = 'send_to_pipefy'
      import.csv_lines.map! do |line|
        line << import.model.collect_id.to_s
        line << (import.model.send_to_pipefy.to_i == 1)
        line
      end
    },
    after_import: proc { |import|
      if import.model.send_to_pipefy.to_i == 1
        import.import_result.ids.each do |id|
          UpdateCardContactWorker.perform_async(id)
        end
      end
    }

  filter :collect, label: i18n_for("contact", "collect_id"),
    as: :select, collection: proc { Collect.all }

  index do
    column i18n_for("contact", "collect_id") do |contact|
      contact.collect.name
    end
    column i18n_for("contact", "school_inep") do |contact|
      contact.school.name
    end
    column :school_phone
    column :principal_name
    column :principal_phone
    column :principal_email
    column :coordinator1_name
    column :coordinator1_phone
    column :coordinator1_email
    column :coordinator2_name
    column :coordinator2_phone
    column :coordinator2_email
    column :coordinator3_name
    column :coordinator3_phone
    column :coordinator3_email
    column :member_email
  end

  controller do
    before_action(only: :index) { check_auth }

    def check_auth
      return if current_admin_user.admin?
      redirect_to admin_root_path, notice: I18n.t("errors.unauthorized")
    end
  end
end
