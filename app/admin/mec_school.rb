ActiveAdmin.register MecSchool do
  permit_params :inep, :name
  actions :all, except: [:new, :edit, :destroy]
end
