class MatchesController < InheritedResources::Base
  before_filter :authenticate_player!

  layout 'mobile'

  def show
    show! do
      @players = @match.teams.map { |team| [team.captain, team.player] }.flatten
    end
  end
  
  def new
    new! do
      @match.teams.build
      @match.teams.build
      
      @courses = Course.all.map { |course| ["#{course.name} (#{course.club.name})", course.id] }
    end
  end
  
  def prev_hole
    @match = Match.find(params[:id])
    @match.prev_hole!
    
    redirect_to :back
  end
  
  def next_hole
    @match = Match.find(params[:id])
    @match.next_hole!
    
    redirect_to :back
  end
  
  def goto_hole
    @match = Match.find(params[:id])
    @match.goto_hole!(params[:nr].to_i)

    redirect_to :back
  end
  
  def results
    @match = Match.find(params[:id])
  end
  
  def score
    @match = Match.find(params[:id])
    @match.update_attributes(params[:match])
    @match.next_hole!
    
    redirect_to :back
  end
end
