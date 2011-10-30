class Player < ActiveRecord::Base
  has_many :matches, :dependent => :destroy
  
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
    "#{first_name.chars.first}#{last_name.chars.first}".upcase
  end
end
