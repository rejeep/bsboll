class Match < ActiveRecord::Base
  belongs_to :course
  belongs_to :hole
  belongs_to :player
  has_many :teams
  has_many :scores

  validates :course, :presence => true

  accepts_nested_attributes_for :teams
  accepts_nested_attributes_for :scores

  def set_initial_hole
    self.hole = course.holes.find_by_nr(1)
  end
  before_create :set_initial_hole

  def prev_hole!
    prev_nr = hole.nr - 1
    if (1..18).include?(prev_nr)
      self.hole = course.holes.find_by_nr(prev_nr)
    end
    save!
  end

  def next_hole!
    next_nr = hole.nr + 1
    if (1..18).include?(next_nr)
      self.hole = course.holes.find_by_nr(next_nr)
    else
      self.hole = nil
    end
    save!
  end

  def goto_hole!(nr)
    if (1..18).include?(nr)
      self.hole = course.holes.find_by_nr(nr)
    end
    save!
  end

  def score_for(player, hole = nil)
    Score.find_by_match_id_and_hole_id_and_player_id(self.id, hole || self.hole.id, player.id) || self.scores.build
  end

  def finished?
    hole.nil?
  end

  def team_1
    teams.first
  end

  def team_2
    teams.last
  end

  def has_score?(hole)
    Score.find_all_by_match_id_and_hole_id(self.id, hole).size == 4
  end

  def score
    player_1 = team_1.captain
    player_2 = team_1.player
    player_3 = team_2.captain
    player_4 = team_2.player

    shots_player_1 = team_1.shots_captain
    shots_player_2 = team_1.shots_player
    shots_player_3 = team_2.shots_captain
    shots_player_4 = team_2.shots_player

    team_1_score = 0
    team_2_score = 0

    course.holes.each do |hole|
      break unless has_score?(hole)

      hcp = hole.hcp
      par = hole.par
      
      team_1_score_hole = 0
      team_2_score_hole = 0

      shots_extra_on_hole_player_1 = (shots_player_1 / 18) + ((shots_player_1 % 18) >= hcp ? 1 : 0)
      shots_extra_on_hole_player_2 = (shots_player_2 / 18) + ((shots_player_2 % 18) >= hcp ? 1 : 0)
      shots_extra_on_hole_player_3 = (shots_player_3 / 18) + ((shots_player_3 % 18) >= hcp ? 1 : 0)
      shots_extra_on_hole_player_4 = (shots_player_4 / 18) + ((shots_player_4 % 18) >= hcp ? 1 : 0)

      score_on_hole_player_1 = score_for(player_1, hole).score
      score_on_hole_player_2 = score_for(player_2, hole).score
      score_on_hole_player_3 = score_for(player_3, hole).score
      score_on_hole_player_4 = score_for(player_4, hole).score

      point_on_hole_player_1 = [(par + shots_extra_on_hole_player_1) - score_on_hole_player_1 + 2, 0].max
      point_on_hole_player_2 = [(par + shots_extra_on_hole_player_2) - score_on_hole_player_2 + 2, 0].max
      point_on_hole_player_3 = [(par + shots_extra_on_hole_player_3) - score_on_hole_player_3 + 2, 0].max
      point_on_hole_player_4 = [(par + shots_extra_on_hole_player_4) - score_on_hole_player_4 + 2, 0].max

      team_1_worst_ball, team_1_best_ball = [point_on_hole_player_1, point_on_hole_player_2].sort
      team_2_worst_ball, team_2_best_ball = [point_on_hole_player_3, point_on_hole_player_4].sort
      
      if team_1_best_ball > team_2_best_ball
        team_1_score_hole += 2
      elsif team_1_best_ball < team_2_best_ball
        team_2_score_hole += 2
      end

      if team_1_worst_ball > team_2_worst_ball
        team_1_score_hole += 1
      elsif team_1_worst_ball < team_2_worst_ball
        team_2_score_hole += 1
      end

      if points_for_birdie > 0
        if par == score_on_hole_player_1 + 1 || par == score_on_hole_player_2 + 1
          team_1_score_hole += points_for_birdie
        end

        if par == score_on_hole_player_3 + 1 || par == score_on_hole_player_4 + 1
          team_2_score_hole += points_for_birdie
        end
      end
      
      team_1_score += team_1_score_hole
      team_2_score += team_2_score_hole
    end
    
    team_min_score = [team_1_score, team_2_score].min

    [team_1_score - team_min_score, team_2_score - team_min_score]
  end
  
  def players
    [team_1.captain, team_1.player, team_2.captain, team_2.player]
  end
end
