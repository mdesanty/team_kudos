class CreateKudoService
  def self.execute(slack_team_data, from_slack_user_data, to_slack_user_data, message)
    return new.execute(slack_team_data, from_slack_user_data, to_slack_user_data, message)
  end

  def execute(slack_team_data, from_slack_user_data, to_slack_user_data, message)
    initialize_variables

    @slack_team_data = slack_team_data
    @from_slack_user_data = from_slack_user_data
    @to_slack_user_data = to_slack_user_data
    @message = message

    return create_kudo
  end

  private

  def initialize_variables
    @from_slakc_user_data = nil
    @to_slack_user_data = nil
    @message = nil
  end

  def create_kudo
    return Kudo.create!(slack_team: slack_team, from_slack_user: from_slack_user, to_slack_user: to_slack_user, message: @message)
  end

  def slack_team
    return @slack_team ||= SlackTeam.where(slack_identifier: @slack_team_data[:slack_identifier]).first_or_create!
  end

  def from_slack_user
    return @from_slack_user ||= SlackUser.where(slack_team: slack_team, slack_identifier: @from_slack_user_data[:slack_identifier]).first_or_create!
  end

  def to_slack_user
    return @to_slack_user ||= SlackUser.where(slack_team: slack_team, slack_identifier: @to_slack_user_data[:slack_identifier]).first_or_create!
  end
end