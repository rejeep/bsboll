class Player < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  validates :first_name, :last_name, :presence => true
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def to_s
    name
  end
  
  def initials
    Namn::Base.new(first_name, last_name).initials
  end
end
