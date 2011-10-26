class CoursesController < InheritedResources::Base
  before_filter :authenticate_player!

  def new
    new! do
      (1..18).each do |nr|
        @course.holes.build(:nr => nr)
      end
    end
  end
  
  def create
    create! { courses_path }
  end

  def update
    update! { courses_path }
  end

  def destroy
    destroy! { courses_path }
  end
end
