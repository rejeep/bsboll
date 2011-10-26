class Hole < ActiveRecord::Base
  belongs_to :course
  
  def to_s
    nr.to_s
  end
end
