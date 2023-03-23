class User< ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_one :user_detail, dependent: :destroy
  has_one :role, dependent: :destroy
  has_many :devices
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,:jwt_authenticatable, jwt_revocation_strategy: self
  accepts_nested_attributes_for :user_detail, :role, update_only: true

  validates :email,presence:true,uniqueness: true
  validates :status, inclusion: {in: %w[active pending resign],message: "invalid status"}

   
  scope :search_user, ->(search) { if search.present?
    joins(:user_detail).where( ["first_name ILIKE ? OR last_name ILIKE ? OR CAST(phone_number AS TEXT) ILIKE ?", 
     "%#{search}%", "%#{search}%", "%#{search}%"] ).where(status: "active")
    else
      where(status: "active")
    end
    }
  
  STATUSES = %w[pending active resign]
  STATUSES.each do |st|
    define_method "#{st}?" do
      self.status == st
    end
  end

  ROLES = %w[hr_manager facility_manager employee]

  ROLES.each do |role_name|
    define_method "#{role_name}?" do
     self.role.role == role_name
    end
  end 
  
  def jwt_payload
   super
  end
  
  def generate_emp_id
    self.emp_id = "PR#{self.id.to_s.rjust(3, '0')}"
    self.save
  end

  def assign_status
    self.status = "active"
    self.save
  end

  def approve_user
    generate_emp_id
    assign_status
  end
end
