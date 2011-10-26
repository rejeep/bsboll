class Course < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => { :scope => :club_id }
  validates :club, :presence => true
  
  belongs_to :club
  has_many :holes, :order => :nr
  
  accepts_nested_attributes_for :holes
end
