ActiveAdmin.register Administration do
  menu priority: 8, if: -> { current_admin_user.sub_admin? }
  permit_params :adm, :state_id, :city_id, :preposition, :name, :cod
  actions :all, except: [:edit, :show]
  config.batch_actions = false
  breadcrumb do
  end

  filter :name_cont, label: "Descrição"
  filter :cod_cont, label: "Código da Rede"
  filter :adm, label: "", as: :check_boxes, collection: Administration.adms.collect { |k,v| [k, v]}
  index do
    column :name
    column :cod
    actions
  end

  form do |f|
    inputs do
      input :adm, as: :select, collection: Administration.adms.keys

      input :state_id, as: :select, collection: State.all.order(:name), input_html: { disabled: true }
      input :city_id, as: :select, collection: City.first(2), input_html: { disabled: true }
      input :preposition, as: :select, collection: %w[da de do], input_html: { disabled: true }
      input :name, input_html: { readonly: true }
      input :cod, input_html: { readonly: true }
    end
    actions
  end
end
