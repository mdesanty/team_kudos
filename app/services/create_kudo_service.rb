class CreateKudoService
  def self.execute(message, options_hash)
    return new.execute(message, options_hash)
  end

  def execute(message, options_hash)
    initialize_variables

    @message = message

    @slack_team_identifier = options_hash[:slack_team_identifier]
    @from_slack_user_identifier = options_hash[:from_slack_user_identifier]
    @to_slack_user_identifier = options_hash[:to_slack_user_identifier]

    create_kudo
    return @kudo
  end

  private

  def initialize_variables
    @message = nil
    @slack_team_identifier = nil
    @from_slack_user_identifier = nil
    @to_slack_user_identifier = nil
  end

  def create_kudo
    @kudo = Kudo.create!(slack_team: slack_team, from_slack_user: from_slack_user, to_slack_user: to_slack_user, message: @message)
  end

  def slack_team
    return @slack_team ||= SlackTeam.where(slack_identifier: @slack_team_identifier).first_or_create!
  end

  def from_slack_user
    return @from_slack_user ||= SlackUser.where(slack_team: slack_team, slack_identifier: @from_slack_user_identifier).first_or_create!
  end

  def to_slack_user
    return @to_slack_user ||= SlackUser.where(slack_team: slack_team, slack_identifier: @to_slack_user_identifier).first_or_create!
  end
end