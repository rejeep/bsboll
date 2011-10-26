class ClubsController < InheritedResources::Base
  before_filter :authenticate_player!
  
  def create
    create! { clubs_path }
  end
  
  def update
    update! { clubs_path }
  end
  
  def destroy
    destroy! { clubs_path }
  end
end
