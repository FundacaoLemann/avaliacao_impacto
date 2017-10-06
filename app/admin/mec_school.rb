ActiveAdmin.register MecSchool do
  menu label: "Escola MEC"
  permit_params :inep, :name
  actions :index
  remove_filter :created_at, :updated_at

  index do
    column :inep
    column :name
  end
end
