ActiveAdmin.register School do
  menu label: "Escola"
  permit_params :inep, :name
  remove_filter :created_at, :updated_at
end
