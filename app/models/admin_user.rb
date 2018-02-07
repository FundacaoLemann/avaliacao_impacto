class AdminUser < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:admin, :service_manager, :service_analyst, :lemann]

  def sub_admin?
    admin? || service_manager?
  end
end
