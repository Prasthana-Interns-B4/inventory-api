class Role < ApplicationRecord
  belongs_to :employee

  ROLES = %w[hr_manager facility_manager employee]

  ROLES.each do |role_name|
    define_method "#{role_name}?" do
      role == role_name
    end
  end
end
