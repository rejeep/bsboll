class Club < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :courses, :dependent => :destroy
  
  def to_s
    name
  end
end
