class Course < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => { :scope => :club_id }
  validates :club, :presence => true
  
  belongs_to :club
end
