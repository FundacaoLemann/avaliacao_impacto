include ActiveAdmin::ViewsHelper
ActiveAdmin.register School do
  form partial: 'form'
  menu priority: 11, if: -> { current_admin_user.sub_admin? }
  permit_params :name, :adm_cod, :tp_dependencia_desc, :region, :location, :num_estudantes, :num_students_fund, :ano_censo, :sample
  config.clear_action_items!
  active_admin_import
  config.sort_order = "inep_asc"

  scope :fundamental

  filter :inep_cont, label: i18n_for("school", "inep")
  filter :name_cont, label: i18n_for("school", "name")
  filter :unidade_federativa_cont, label: i18n_for("school", "unidade_federativa")
  filter :municipio_cont, label: i18n_for("school", "municipio")
  filter :administration, label: i18n_for("school", "adm_cod"),
    as: :select, collection: proc { Administration.all }
  filter :region, label: i18n_for("school", "region"),
    as: :check_boxes, collection: School::REGIONS
  filter :location, label: i18n_for("school", "location"),
    as: :check_boxes, collection: School::LOCATIONS
  filter :tp_dependencia_desc, label: i18n_for("school", "tp_dependencia_desc"),
    as: :check_boxes, collection: %w[Estadual Federal Municipal Privada]

  index do
    column :inep
    column :name
    column i18n_for("school", "adm_cod") do |school|
      school.administration.name unless school.administration.blank?
    end
    column :municipio
    column :unidade_federativa
    column :tp_dependencia_desc
    column :region
    column :location
    column :num_estudantes
    column :num_students_fund
    column :ano_censo
    actions :defaults => false do |school|
      link_to I18n.t('active_admin.edit'), edit_admin_school_path(school)
    end
  end
end
