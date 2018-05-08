include ActiveAdmin::ViewsHelper
ActiveAdmin.register School do
  menu priority: 11, if: -> { current_admin_user.sub_admin? }
  permit_params :inep, :name, :tp_dependencia, :tp_dependencia_desc, :cod_municipio,
    :municipio, :unidade_federativa, :num_estudantes, :ano_censo, :adm_cod
  config.clear_action_items!
  active_admin_import
  config.sort_order = "inep_asc"

  scope :fundamental

  filter :inep_cont, label: i18n_for("school", "inep")
  filter :name_cont, label: i18n_for("school", "name")
  filter :unidade_federativa_cont, label: i18n_for("school", "unidade_federativa")
  filter :municipio_cont, label: i18n_for("school", "municipio")
  filter :administration, label: i18n_for("school", "adm_cod"),
    as: :select, collection: Administration.all
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
  end
end
