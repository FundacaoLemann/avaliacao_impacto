include ActiveAdmin::ViewsHelper
ActiveAdmin.register Administration do
  menu priority: 2, parent: "Gerenciar Coletas", if: -> { current_admin_user.sub_admin? }
  permit_params :adm, :state_id, :city_ibge_code, :preposition, :name, :cod, :contact_name
  actions :all, except: [:show, :destroy]

  filter :name_cont, label: i18n_for("administration", "name")
  filter :cod_cont, label: i18n_for("administration", "cod")
  filter :contact_name_cont, label: i18n_for("administration", "contact_name")
  filter :adm, label: "", as: :check_boxes,
    collection: Administration.adms.collect { |k, v| [k, v] }

  index do
    column :name
    column :cod
    column :contact_name
    actions
  end

  form do |f|
    inputs do
      input :adm, as: :select, collection: Administration.adms.keys
      input :state_id, as: :select, collection: State.all.order(:name), input_html: { disabled: true }
      input :city_ibge_code, as: :select, collection: City.first(2), input_html: { disabled: true }
      input :preposition, as: :select, collection: %w[da de do], input_html: { disabled: true }
      input :contact_name
      input :name, input_html: { readonly: true }
      input :cod, input_html: { readonly: true }
    end
    actions
  end
end
