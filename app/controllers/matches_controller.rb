class MatchesController < InheritedResources::Base
  layout 'mobile'

  before_filter :authenticate_player!
  before_filter :only => [:show, :results, :score, :goto_hole, :prev_hole, :next_hole] do
    @match = Match.find(params[:id])
    unless @match.players.include?(current_player)
      render :text => 'Foo'
    end
  end


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
    @match.prev_hole!

    redirect_to :back
  end

  def next_hole
    @match.next_hole!

    redirect_to :back
  end

  def goto_hole
    @match.goto_hole!(params[:nr].to_i)

    redirect_to :back
  end

  def results
  end

  def score
    @match.update_attributes(params[:match])
    @match.next_hole!

    redirect_to :back
  end
end
