class Course < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => { :scope => :club_id }
  validates :club, :presence => true
  
  belongs_to :club
  has_many :holes, :order => :nr
  has_many :matches
  
  accepts_nested_attributes_for :holes
  
  def to_s
    name
  end
end
