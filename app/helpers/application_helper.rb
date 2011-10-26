module ApplicationHelper
  def team_initials(team)
    [team.captain.initials, team.player.initials].join(' & ')
  end
end
