class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_one :user_detail, dependent: :destroy
  has_one :role, dependent: :destroy
  has_many :devices
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,:jwt_authenticatable, jwt_revocation_strategy: self
  def jwt_payload
    super
  end

  STATUSES = %w[pending active resign]

  STATUSES.each do |st|
    define_method "#{st}?" do
      self.status == st
    end
  end

  ROLES = %w[hr_manager facility_manager user]

  ROLES.each do |role_name|
    define_method "#{role_name}?" do
      self.role.role == role_name
    end
  end

  def create_by_hr_manager(params)
    self.emp_id = "PR#{self.id.to_s.rjust(3, '0')}"
    self.status = "active"
    self.create_user_detail(params)
    self.create_role
    return self if self.save
  end

  def create_by_user(params)
    self.create_user_detail(params)
    self.create_role
    return self if self.save
  end
end
