class CoursesController < InheritedResources::Base
  before_filter :authenticate_player!

  def index
    index! do
      @clubs = Club.all
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
